//
//  File.swift
//  swiftDemo
//
//  Created by peter on 2019/1/17.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol Company {
    
    func buy<T>(product:T,with money:Int)
    
    func sell<T>(product:T.Type,for money:Int) ->T?
    
}


protocol Router {
    
    func route(
        to routeID:String,
        from context:UIViewController,
        parameters:Any?
    )
    
}

class LoginControler:UIViewController {
    
    enum Route:String{
        
        case login
        case singup
        case forgotPwd
        
        
    }
    
    override func viewDidLoad() {
        
        
    }
    
    
    
}


