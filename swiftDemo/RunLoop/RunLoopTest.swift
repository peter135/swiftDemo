//
//  RunLoopTest.swift
//  swiftDemo
//
//  Created by peter on 2018/11/29.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit

class RunLoopTest{
    
    fileprivate func addRunLoopObserver() {
        
        do {
            
            let block = { (ob:CFRunLoopObserver?,ac:CFRunLoopActivity) in
                
                if ac == .entry {
                    print("进入 Runloop")
                }
                else if ac == .beforeTimers {
                    print("即将处理 Timer 事件")
                    
                }
                else if ac == .beforeSources {
                    print("即将处理 Source 事件")
                    
                }
                else if ac == .beforeWaiting {
                    print("Runloop 即将休眠")
                    
                }
                else if ac == .afterWaiting {
                    print("Runloop 被唤醒")
                    
                }
                else if ac == .exit {
                    print("退出 Runloop")
                }
                
                
            }
            
            let ob =  createRunloopObserver(block: block)
            
            CFRunLoopAddObserver(CFRunLoopGetCurrent(), ob, .defaultMode)
            
        }
            
//        catch RunloopError.canNotCreate {
//            print("runloop 观察者创建失败")
//        }
//
//        catch {
//
//
//        }
        
        
    }
    
    
    fileprivate func createRunloopObserver(block: @escaping (CFRunLoopObserver?, CFRunLoopActivity) -> Void)  -> CFRunLoopObserver? {

        
        let ob = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, block)
        guard let observer = ob else {
            
            return nil
            
        }
        return observer
        
    }
    

    
    
}
