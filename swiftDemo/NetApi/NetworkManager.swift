//
//  NetworkManager.swift
//  swiftDemo
//
//  Created by peter on 2018/10/15.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let networkStaticHeaderKey = "topscommToken"
let Authorization = "Authorization"
let token = "token"

public enum DataKey:String {
    
    case all = "all"
    case dataMap = "dataMap"
    case dataList = "dataList"
    case listDataMap = "listDataMap"
    case actionResult = "actionResult"
    case none = "none"
}

public enum NetworkType {
    case normalRequest
    case upload
    case download
}

public enum ErrorCode {
    case invalidResponse(String)
    case serverError(String)
    case networkUnavailable(String?,Int?)
    case needRetrier(URLRequest,NetworkType,DataKey?,String)
    case uploadError(String,[String],JSON,[Data],[String],String?)

}

public typealias Success<T> = (T)->Void
public typealias Failure = (ErrorCode) -> Void

public final class NetworkTool{
    private init() {}
    
    static let shared = NetworkTool()
    
    var sessionManager: SessionManager = {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 30
            let manger = Alamofire.SessionManager(configuration: config)
            return manger
        }()
}

extension NetworkTool {
   
    public static func getNormalRequestWith(url: String,
                                         param: Parameters,
                                         networkType:NetworkType,
                                         method: HTTPMethod = .post,
                                         dataKey: DataKey = .all,
                                         success: @escaping Success<JSON>,
                                         failure: @escaping Failure) {
        
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        
        shared.sessionManager.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headers)
            .validate() //200...299
            .responseJSON { (response) in

                switch response.result {
                case .success:
                    if let data = response.data{
//                        let actionReuslt = JSON(data)[ConstantsHelp.actionReuslt]
//                        if actionReuslt[ConstantsHelp.success].boolValue {
//                            let json = JSON(data)[dataKey.rawValue]
//                            //MARK:-存token
//                            if  !JSON(data)[ConstantsHelp.dataMap][token].stringValue.isEmpty {
//                                UserDefaults.standard.set(JSON(data)[ConstantsHelp.dataMap][token].stringValue, forKey: networkStaticHeaderKey)
//                            }
//                            success(json)
//                        } else {
//                            let message = (actionReuslt[ConstantsHelp.message].stringValue)
//                            failure(.sysError(message))
//
//                        }
                }

                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504{
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.serverError(error.localizedDescription))
                        }
                    } else {
                        failure(.serverError(error.localizedDescription))
                    }
                }
        }
    }

    public static func uploadRequestWith(url: String,
                                         keys: [String],
                                         parameters: JSON,
                                         datasArr:[Data],
                                         dataKey: DataKey = .actionResult,
                                         datasInfoArr:[String],
                                         networkType:NetworkType,
                                         success: @escaping Success<JSON>,
                                         failure: @escaping Failure){
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        shared.sessionManager.upload(multipartFormData: { (multipartFormData) in
            //拼接数据
            var count = datasArr.count
            count = datasArr.count <= datasInfoArr.count ? datasArr.count:datasInfoArr.count
            for index in 0..<count {
                let data = datasArr[index]
                
//                let withName = !VerifyHelp.checkImageInfo(imageName: datasInfoArr[index]) ? "withName" + String(index) + data.getImageFormat()!: datasInfoArr[index]
//                let fileName = !VerifyHelp.checkImageInfo(imageName: datasInfoArr[index]) ? "fileName" + String(index) + data.getImageFormat()! : datasInfoArr[index]
                
                let withName =  datasInfoArr[index]
                let fileName =  datasInfoArr[index]
                               
                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: "application/octet-stream")
            }
            if keys.count > 0{
                for value in keys{
                    let data:Data = parameters[value].stringValue.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                    multipartFormData.append(data, withName:value)
                }
            }
            
            multipartFormData.append(URL(string:"sss")!, withName: "ss", fileName: "ssd", mimeType: "jpeg/jpg")
            
        }, to: url, headers: headers) { (request) in
            switch request {
            case .success(let upload, _ , _):
                upload.responseJSON { (response) in
                    //是否存在错误
                    if let error = response.error {
                        if let code = response.response?.statusCode {
                            if code == 500 || code == 502 || code == 503 || code == 504 || code == 404{
                                if let request = response.request {
                                    failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                }
                            } else {
                                failure(.serverError(error.localizedDescription))
                            }
                        } else {
                            //offline 无状态码
                            failure(.networkUnavailable(error.localizedDescription, nil))
                        }

                    } else {
                        //成功
                        if let data = response.result.value as? [String : AnyObject] {
//                            let actionResult = JSON(data)[ConstantsHelp.actionReuslt]
//                            if  actionResult[ConstantsHelp.success].boolValue {
//                                success(actionResult)
//                            } else {
//                                let message = (actionResult[ConstantsHelp.message].stringValue)
//                                failure(.sysError(message))
//                            }
                        }
                    }
                }
            case .failure:
                failure(.serverError("上传的数据不合法"))
            }
        }
    }
    
    public static func downloadFileWith(url: String,
                                        method: HTTPMethod = .post,
                                        dataKey: DataKey = .none,
                                        params: Parameters,
                                        networkType:NetworkType,
                                        success: @escaping Success<String>,
                                        failure: @escaping Failure) {
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        shared.sessionManager.download(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers, to: destination).responseData { (response) in
            switch response.result {
            case .success:
                if let path = response.destinationURL?.path{
                    if path.hasSuffix("action") {
                        failure(.serverError("下载的文件不存在"))
                    } else {
                        success(path)
                    }
                }else {
                    if let error = response.error {
                        if let code = response.response?.statusCode {
                            if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                                if let request = response.request {
                                    failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                }
                            } else {
                                failure(.serverError(error.localizedDescription))
                            }
                        }
                    }
                }
            case .failure(let error):
                if let code = response.response?.statusCode {
                    if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                        if let request = response.request {
                            failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                        }
                    } else {
                        failure(.serverError(error.localizedDescription))
                    }
                } else {
                    failure(.serverError(error.localizedDescription))
                }
            }
        }
    }
    
    //MARK:- 重试方法
    public static  func getRetrierRequest(request:URLRequest,
                                           dataKey: DataKey?,
                                           networkType: NetworkType,
                                           success: @escaping Success<Any>,
                                           failure: @escaping Failure) {
        
        switch networkType {
        case .normalRequest:
            shared.sessionManager.request(request).validate().responseJSON { (response) in
                //在200...299之外
                if let error = response.error {
                    failure(.invalidResponse(error.localizedDescription))
                }
                switch response.result {
                case .success:
                    if let data = response.data{
//                        let actionReuslt = JSON(data)[ConstantsHelp.actionReuslt]
//                        if actionReuslt[ConstantsHelp.success].boolValue {
//                            let json = JSON(data)[dataKey!.rawValue]
//                            success(json)
//                        } else {
//                            let message = (actionReuslt[ConstantsHelp.message].stringValue)
//                            failure(.sysError(message))
//                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504 {
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.serverError(error.localizedDescription))
                        }
                    } else {
                        failure(.serverError(error.localizedDescription))
                    }
                }
            }
        case .download:
            let destination: DownloadRequest.DownloadFileDestination = { _, response in
                let documentsURL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            shared.sessionManager.download(request, to: destination).validate().responseData { (response) in
                switch response.result {
                case .success:
                    if let path = response.destinationURL?.path{
                        if path.hasSuffix("action") {
                            failure(.serverError("下载的文件不存在"))
                        } else {
                            success(path)
                        }
                    }else {
                        if let error = response.error {
                            if let code = response.response?.statusCode {
                                if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                                    if let request = response.request {
                                        failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                    }
                                } else {
                                    failure(.serverError(error.localizedDescription))
                                }
                            }
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504{
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.serverError(error.localizedDescription))
                        }
                    } else {
                        failure(.serverError(error.localizedDescription))
                    }
                }
            }
        default:
            break;
        }
    }

}
