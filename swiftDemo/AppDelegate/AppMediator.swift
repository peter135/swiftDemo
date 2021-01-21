//
//  AppLifeCycleMediator.swift
//  swiftDemo
//
//  Created by peter on 2018/12/26.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import UIKit

protocol AppLifeCycleListener {
    
    func onAppWillEnterForground()
    func onAppDidEnterBackground()
    func onAppDidFinishLaunching()

}

extension AppLifeCycleListener{
    
    func onAppWillEnterForground(){}
    func onAppDidEnterBackground(){}
    func onAppDidFinishLaunching(){}
    
}

class VideoListener: AppLifeCycleListener {
    
    func onAppDidEnterBackground() {
        
    }
    
}


class SocketListener:AppLifeCycleListener {
    
    func onAppWillEnterForground() {
        
        
    }
    
}


class AppLifeCycleMediator: NSObject {
    
    private let listeners:[AppLifeCycleListener]
    
    init(listeners:[AppLifeCycleListener]) {
        
        self.listeners = listeners
        super.init()
        subscribe()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    private func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(onAppWillEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidFinishLaunching), name: .UIApplicationDidFinishLaunching, object: nil)
    }
    
    @objc private func onAppWillEnterForeground() {
        listeners.forEach { $0.onAppWillEnterForground() }
    }
    
    @objc private func onAppDidEnterBackground() {
        listeners.forEach { $0.onAppDidEnterBackground() }
    }
    
    @objc private func onAppDidFinishLaunching() {
        listeners.forEach { $0.onAppDidFinishLaunching() }
    }
    
    
}

extension AppLifeCycleMediator {
    
    static func makeDefaultMediator() -> AppLifeCycleMediator {
        
        let listener1 = VideoListener()
        let listener2 = SocketListener()
        
        return AppLifeCycleMediator(listeners: [listener1,listener2])
        
    }
    
    
}
