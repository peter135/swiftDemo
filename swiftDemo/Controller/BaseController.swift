//
//  PTBaseController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/15.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit

class BaseController: UIViewController {
    
    
    override func viewDidLoad() {
        
        let pop = PopAnimator()
        
        self.popTransition = pop
        
        //添加返回手势
        addTransition()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        addTransition()
        
    }
    
    
    deinit {
        
        print("deinit \(self.classForCoder)")
    }
    
}


class BaseNavigationController: UINavigationController{
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count>0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    
}

