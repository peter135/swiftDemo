//
//  ViewControllerExtension.swift
//  swiftDemo
//
//  Created by peter on 2018/10/19.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

import UIKit

private var transitionKey = "transitionKey"
private var transitionDismissKey = "transitionDismissKey"
private var transitionDelegateKey = "transitionDelegateKey"


enum pushType {
    
    case normal
    
    
}


extension UIViewController{
    
    public static func presentChange(){
    
        DispatchQueue.once(token:"UIViewController"){
            let originalSelector = #selector(UIViewController.present(_:animated:completion:))
            let swizzledSelector = #selector(UIViewController.presentExChange(_:animated:completion:))
            changeMethod(originalSelector,swizzledSelector,self)
            
        }
        
    }
    
    @objc func presentExChange(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil){
        
        
//        if let transitionDelegate = viewControllerToPresent.transitioningDelegate {
//
//            self.transitionDelegate_ex = viewControllerToPresent.transitioningDelegate
//        }
        
        viewControllerToPresent.transitioningDelegate = self

            
            
        presentExChange(viewControllerToPresent, animated: flag, completion: completion)
        
        
    }
    
    
    private static func changeMethod(_ original: Selector, _ swizzled: Selector, _ object: AnyClass) -> (){
        guard let originalMethod = class_getInstanceMethod(object, original),
            let swizzledMethod = class_getInstanceMethod(object, swizzled) else {
                return
        }
        
        let didAddMethod = class_addMethod(object, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(object, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    
}


private var interactivePopTransitionKey = "interactivePopTransition"
private var popTransitionKey = "popTransitionKey"

//MARK: push导航控制器 动画代理

extension UIViewController:UINavigationControllerDelegate{
    
    
       public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            print("animationControllerFor")
            
            if (operation == .pop) {
                return popTransition
            }
            
            return nil
            
        }
        
       public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
            
            print("interactivePopTransition")
            return self.interactivePopTransition
            
        }
        
        //    func navigationController(navigationController: UINavigationController!, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning!) -> UIViewControllerInteractiveTransitioning! {
        //
        //        print("interactivePopTransition")
        //        return self.interactivePopTransition
        //
        //    }
        
        
        
  
    
}


extension UIViewController{
    
    
    //MARK:push interactive 属性
    
    var popTransition:UIViewControllerAnimatedTransitioning{
        
        get{
            return objc_getAssociatedObject(self, &popTransitionKey) as! UIViewControllerAnimatedTransitioning
        }
        
        set{
            objc_setAssociatedObject(self, &popTransitionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
        }
    }
    
    
    
    var interactivePopTransition:UIPercentDrivenInteractiveTransition?{
        
        get{
            return objc_getAssociatedObject(self, &interactivePopTransitionKey) as? UIPercentDrivenInteractiveTransition
        }
        
        set{
            objc_setAssociatedObject(self, &interactivePopTransitionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    
    
    open func addTransition()  {
        
        self.navigationController?.delegate=self

        
        let popRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action:#selector(handlePopRecognizer) )
        
        popRecognizer.edges = .left
        
        self.view.addGestureRecognizer(popRecognizer)
        
        //        UIScreenEdgePanGestureRecognizer继承于UIPanGestureRecognizer，能检测从屏幕边缘滑动的手势，设置edges为left检测左边即可。然后实现handlePopRecognizer:
        //
        
    }
    
    @objc func handlePopRecognizer(popRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        var progress = popRecognizer.translation(in:self.view).x / (self.view.bounds.size.width)
        
        progress = min(1.0, max(0.0, progress))
        
//        print("\(progress)")
        


        if popRecognizer.state == UIGestureRecognizerState.began {
            
            
            
//            print("Began")
            self.interactivePopTransition   = UIPercentDrivenInteractiveTransition()
            
            self.navigationController?.popViewController(animated: true)
            
            
        } else if popRecognizer.state == UIGestureRecognizerState.changed {
            
            self.interactivePopTransition?.update(progress)
            
            
//            print("Changed")
            
        } else if popRecognizer.state == UIGestureRecognizerState.ended || popRecognizer.state == UIGestureRecognizerState.cancelled {
            
            if progress > 0.5 {
                
                self.interactivePopTransition?.finish()
                

                //                self.navigationController?.popViewController(animated: true)
                
//                print("Finished")
                
                
            } else {
                
                self.interactivePopTransition?.cancel()
//                print("Cancelled")
                
            }
            
            //            self.interactivePopTransition = nil
            
        }
        
    }
    
    
    
}


extension UIViewController{
    
    //MARK:present 属性
    var transitionDelegate_ex:UIViewControllerTransitioningDelegate?{
        
        get{
            return objc_getAssociatedObject(self, &transitionDelegateKey) as? UIViewControllerTransitioningDelegate
        }
        
        set{
            objc_setAssociatedObject(self, &transitionDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    
    var transitionPresent:UIViewControllerAnimatedTransitioning{
        
        get{
            return objc_getAssociatedObject(self, &transitionKey) as? UIViewControllerAnimatedTransitioning ?? SwipeAnimator()
        }
        
        set{
            objc_setAssociatedObject(self, &transitionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    var transitionPresentDismiss:UIViewControllerAnimatedTransitioning{
        
        get{
            return objc_getAssociatedObject(self, &transitionDismissKey) as? UIViewControllerAnimatedTransitioning ?? SwipeDismissAnimator()
        }
        
        set{
            objc_setAssociatedObject(self, &transitionDismissKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    
    
}

//MARK: present 动画代理
extension UIViewController: UIViewControllerTransitioningDelegate{

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return transitionPresent
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return transitionPresentDismiss

    }

}
