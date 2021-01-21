//
//  PresentController.swift
//  swiftDemo
//
//  Created by Fubao on 2018/7/25.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import UIKit
import Alamofire

class ChildController: UIViewController {

//    var navigation:BaseNavViewController?

//    var popTransition = PopAnimator()

    var name:String?
    var parameter:[String:Any]
    var shapeLayer:CALayer?
    
    convenience init(parameter:[String:Any]){
        
        self.init(name: nil, parameter: parameter)
        
    }
    
    init(name:String?,parameter:[String:Any]) {
        
        self.name = name
        self.parameter = parameter
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    deinit {
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addTransition()

        addShapeLayer()
        
        addBtn()
        
        addAnimation()
        
        addRequest()
        
        addDowndload()
        

    }
    
    
    func addRequest() {
        
        let btn = UIButton.init(frame: CGRect.init(x: 40, y:100, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("request", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(request), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
    }
    
    
    func addDowndload() {
        
        let btn = UIButton.init(frame: CGRect.init(x: 180, y:100, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("download", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(download), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
    }
    
    
    func addShapeLayer()  {
        
        let startPoint = CGPoint.init(x: 50, y: 300)
        let endPoint = CGPoint.init(x: 300, y: 300)
        let controlPoint = CGPoint.init(x: 170, y: 200)
        
        
        let layer1 = CALayer()
        layer1.frame = CGRect.init(x:startPoint.x, y:startPoint.y, width:5, height: 5)
        layer1.backgroundColor = UIColor.red.cgColor
        
        let layer2 = CALayer()
        layer2.frame = CGRect.init(x:endPoint.x, y:endPoint.y, width:5, height: 5)
        layer2.backgroundColor = UIColor.red.cgColor
        
        let layer3 = CALayer()
        layer3.frame = CGRect.init(x:controlPoint.x, y:controlPoint.y, width:5, height: 5)
        layer3.backgroundColor = UIColor.red.cgColor
        
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.backgroundColor = UIColor.red.cgColor
        
        shapeLayer = layer
        
        view.layer.addSublayer(layer)
        view.layer.addSublayer(layer1)
        view.layer.addSublayer(layer2)
        view.layer.addSublayer(layer3)
        
    
    }
    

    func addBtn() {
        
        let btn = UIButton.init(frame: CGRect.init(x: 200, y:400, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("返回转场", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(tapped), for: .touchUpInside)

        self.view.addSubview(btn)
        
    }
    
    func addAnimation() {
        
        let btn = UIButton.init(frame: CGRect.init(x: 40, y:400, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("Animation", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(animation), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
    }
    
    @objc func request() {
        
        self.view.loadText(text: "加载中")

        Alamofire.request("https://httpbin.org/post",
                          method: .post,
                          parameters: ["foo":"bar"],
                          encoding: JSONEncoding.default, headers:nil)
                          .responseJSON { (response) in
            
                            print("response \(response.result)")
                            self.view.dismissLoading()

            
        }
        
    }
    
    @objc func download() {
        
        let urlString = "https://httpbin.org/image/jpeg"
        
        let distination:DownloadRequest.DownloadFileDestination = {_,_ in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("pig.png")
            
            return (fileURL,[.removePreviousFile,.createIntermediateDirectories])
        }
        
        Alamofire.download(urlString, to: distination)
            .downloadProgress { progress in
                
                print("Download Progress: \(progress.fractionCompleted)")
                
            }.response{ response in
                
                print("response data \(response)")

            
        }
            

    }
    
    
    @objc func animation() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        shapeLayer?.add(animation, forKey: "")
        
    }
    
    
    @objc func tapped() {
        
//      self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    

}


