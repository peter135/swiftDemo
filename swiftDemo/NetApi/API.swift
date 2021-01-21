//
//  API.swift
//  swiftDemo
//
//  Created by peter on 2018/10/15.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import Moya

enum API {
    
    case testApi
    case testApiStr(para1:String,para2:String)
    case testApiDict(Dict:[String:Any])
    
}

extension API:TargetType{
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!

    }
    
    
    var baseURL:URL {
        
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
    
    var path:String {
        
        switch  self {
            
        case .testApi:
            return "4/news/latest"
            
        case .testApiStr(let para1,_):
            return "\(para1)/news/latest"
            
        case .testApiDict:
        
            return "4/news/latest"

        }
        
    }
    
    /// 请求方式 get post put delete
    var method: Moya.Method {
        switch self {
        case .testApi:
            return .get
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .testApi:
            return .requestPlain
            
        case let .testApiStr(para1, _):
            return .requestParameters(parameters: ["key":para1], encoding: URLEncoding.default)
            
        case let .testApiDict(dict):
            return .requestParameters(parameters: dict, encoding: JSONEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        //同task，具体选择看后台 有application/x-www-form-urlencoded 、application/json
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
    
    
}
