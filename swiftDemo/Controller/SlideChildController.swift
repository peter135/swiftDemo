//
//  SlideChildController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/16.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

import UIKit

class SlideChildController: UIViewController {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    deinit {
        
        
        
    }
    
    
    public var container:UIScrollView = {
        
        let containerLazy = UIScrollView()
        containerLazy.backgroundColor = .white
        
        containerLazy.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 88 - 49 )
        containerLazy.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight )

        return containerLazy
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(container)
        
    }
    
    
    
}
