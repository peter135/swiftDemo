//
//  AppComposite.swift
//  
//
//  Created by peter on 2018/12/26.
//

import Foundation
import UIKit

enum AppDelegateFactory {
    
    static func makeDefault()->AppdelegateType{
        
        return CompositeAppDelegate(appDelegates:[PushNotificationsAppDelegate(),StartupConfiguratorAppDelegate(),ThirdPartiesConfiguratorAppDelegate()])
        
    }
    
    
}


typealias AppdelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppdelegateType {
    
    private let appDelegates:[AppdelegateType]
    
    init(appDelegates:[AppdelegateType]) {
        
        self.appDelegates = appDelegates
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    
}

class PushNotificationsAppDelegate: AppdelegateType {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Registered successfully
    }
}

class StartupConfiguratorAppDelegate: AppdelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Perform startup configurations, e.g. build UI stack, setup UIApperance
        return true
    }
}

class ThirdPartiesConfiguratorAppDelegate: AppdelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Setup third parties
        return true
    }

}
