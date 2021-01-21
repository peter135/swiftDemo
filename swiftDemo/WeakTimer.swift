//
//  Macro.swift
//  swiftDemo
//
//  Created by peter on 2018/11/16.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit

class WeakTimerTarget {
    
    weak var target:NSObject?
    
    var action:Selector
    
    var actionSel:Selector = #selector(actionM)
    
    init(_ target:NSObject?,action:Selector) {
        
        self.target = target
        self.action = action
        
    }
    
    
    @objc func actionM() {
        
        self.target?.perform(self.action, with: nil)
        
    }
    
}

extension Timer {
    
    func weak_scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool) -> Timer{
        
        let targetWeak = WeakTimerTarget(target as? NSObject, action: selector)
        
        return  Timer.scheduledTimer(timeInterval: timeInterval, target: targetWeak, selector: targetWeak.actionSel, userInfo: userInfo, repeats: repeats)
        
    }
    
    
}
