//
//  PageStack.swift
//  swiftDemo
//
//  Created by peter on 2018/10/29.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public enum StackViewNavigationOperation: Int {
    case none
    case push
    case pop
    
}

protocol ViewSwitchAnimation {
    
    var superView: UIView { get set}
    var superViewHeight: CGFloat {get set}
    var nextViewAnimationAction:((UIView,Bool)->Void)? {get set}
    
    var bottomInset: CGFloat {get set}
    var topInset: CGFloat {get set}
    
}

extension ViewSwitchAnimation{
    
     func animation(operation: StackViewNavigationOperation, topView: UIView, nextView: UIView, animated: Bool,completion: ((Bool) -> Void)?) {
        
        
        
    }
    
}


class StackViewNavigation:ViewSwitchAnimation {
    
    enum viewStauts {
        case didShow, willHidden
    }
    
    var  views: [UIView] = []
    var  isAnimation: Bool = false
    var  topView: UIView
    var  rootView: UIView
    
    var lastTopView: UIView
    fileprivate(set) weak var superViewController: UIViewController?
    
    var superView: UIView
    var nextViewAnimationAction: ((UIView, Bool) -> Void)?
    var bottomInset: CGFloat = 0
    var topInset: CGFloat = 0
    var superViewHeight: CGFloat = 0
    
    var nextViewDidShowAction:((UIView,UIView) -> Void)?
    var topViewWillHiddenAction:((UIView,UIView) -> Void)?
    
    fileprivate var animationDuration: TimeInterval = 0.4

    init(viewController:UIViewController,rootView:UIView) {
        
        self.superViewController = viewController
        self.superView = viewController.view
        self.superViewHeight = viewController.view.bounds.height
        self.rootView = rootView
        self.topView = rootView
        self.lastTopView = rootView
        views.append(rootView)
        
    }
    
    func pushView(_ view:UIView,animated:Bool) -> Bool {
        
        let success = false
        
        return success
        
        
    }
    
    
}

extension StackViewNavigation {
    
    fileprivate func viewAnimation(operation:StackViewNavigationOperation,nextView:UIView,animated:Bool,completion:((Bool)->Void)?)->Bool{
        
        guard !isAnimation else {
            
            print("view animation failure,前一个动画还未结束")
            
            return false
            
        }
        
        topViewWillHiddenAction?(topView,nextView)
        
        isAnimation = true
        
        
        
        
        return true

    }
    
    
}



