//
//  ButtonExtension.swift
//  swiftDemo
//
//  Created by peter on 2018/10/13.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import UIKit

extension DispatchQueue {
    
    private static var onceTracker = [String]()
    
    //Executes a block of code, associated with a unique token, only once.  The code is thread safe and will only execute the code once even in the presence of multithreaded calls.
    public class func once(token: String, block: () -> Void)
    {   // 保证被 objc_sync_enter 和 objc_sync_exit 包裹的代码可以有序同步地执行
        objc_sync_enter(self)
        defer { // 作用域结束后执行defer中的代码
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}

fileprivate extension Selector {
    static let sysFunc = #selector(UIButton.sendAction(_:to:for:))
    static let myFunc = #selector(UIButton.mySendAction(_:to:for:))
    
    
}

private var ts_touchAreaEdgeInset:UIEdgeInsets = .zero



extension UIButton {
    
    public var ts_touchInsets:UIEdgeInsets{
        
        get {
            return (objc_getAssociatedObject(self, &ts_touchAreaEdgeInset) as? UIEdgeInsets) ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &ts_touchAreaEdgeInset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
     
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if UIEdgeInsetsEqualToEdgeInsets(self.ts_touchInsets, .zero)
            || !self.isEnabled
            || self.isHidden {
            return super.point(inside: point, with: event)
        }
        
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.ts_touchInsets)
        
        return hitFrame.contains(point)
        
        
    }
    
    
    
}


extension UIButton {
    
    public static func methondExchange(){
        DispatchQueue.once(token:"UIButton"){
            let originalSelector = Selector.sysFunc
            let swizzledSelector = Selector.myFunc
            changeMethod(originalSelector,swizzledSelector,self)
            
        }
        
        
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
    
    private struct UIButtonKey{
        
        static var isEventUnavailableKey = "isEventUnavailableKey"
        static var eventIntervalKey = "eventIntervalKey"
        
    }
    
    
    /// 触发事件的间隔
    var eventInterval: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &UIButtonKey.eventIntervalKey) as? TimeInterval) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &UIButtonKey.eventIntervalKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 是否可以触发事件
    fileprivate var isEventUnavailable: Bool {
        get {
            return (objc_getAssociatedObject(self, &UIButtonKey.isEventUnavailableKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIButtonKey.isEventUnavailableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 手写的set方法
    ///
    /// - Parameter isEventUnavailable: 事件是否可用
    @objc private func setIsEventUnavailable(_ isEventUnavailable: Bool) {
        self.isEventUnavailable = isEventUnavailable
    }
    
    /// mySendAction
    @objc fileprivate func mySendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
//        print("交换了按钮事件的方法")
        
        if isEventUnavailable == false {
            isEventUnavailable = true
            mySendAction(action, to: target, for: event)
            perform(#selector(setIsEventUnavailable(_: )), with: false, afterDelay: eventInterval)
        }
    }
    
    
}
