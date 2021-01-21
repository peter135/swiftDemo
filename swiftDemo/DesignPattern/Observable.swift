//
//  Observable.swift
//  swiftDemo
//
//  Created by peter on 2018/12/21.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name{
    
    static let networkConnection = Notification.Name("networkConnection")
    static let batteryStatus = Notification.Name("batteryStatus")
    static let locationChange = Notification.Name("locationChange")
    
}

enum NetworkConnectionStatus: String {
    
    case connected
    case disconnected
    case connecting
    case disconnecting
    case error
    
}

// 定义 userInfo 中的 key 值。
enum StatusKey: String {
    case networkStatusKey
}

// 此协议定义了*观察者*的基本结构。
// 观察者即一些实体的集合，它们的操作严格依赖于其他实体的状态。
// 遵循此协议的实例会向某些重要的实体/资源*订阅*并*接收*通知。
protocol ObserverProtocol {
    
    var statusValue: String { get set }
    var statusKey: String { get }
    var notificationOfInterest: Notification.Name { get }
    func subscribe()
    func unsubscribe()
    func handleNotification()
    
}


// 此模版类抽象如何*订阅*和*接受*重要实体/资源的通知的所有必要细节。
// 此类提供了一个钩子方法（handleNotification()），
// 所有的子类可以通过此方法在接收到特定通知时进行各种需要的操作。
// 此类基为一个*抽象*类，并不会在编译时被检测，但这似乎是一个异常场景。
class Observer: ObserverProtocol {
    
    // 此变量与 notificationOfInterest 通知关联。
    // 使用字符串以尽可能满足需要。
    var statusValue: String
    // 通知的 userInfo 中的 key 值，
    // 通过此 key 值读取到特定的状态值并存储到 statusValue 变量。
    // 使用字符串以尽可能满足需要。
    let statusKey: String
    // 此类所注册的通知名。
    let notificationOfInterest: Notification.Name
    
    // 通过传入的通知名和需要观察的状态的 key 值进行初始化。
    // 初始化时会注册/订阅/监听特定的通知并观察特定的状态。
    init(statusKey: StatusKey, notification: Notification.Name) {
        
        self.statusValue = "N/A"
        self.statusKey = statusKey.rawValue
        self.notificationOfInterest = notification
        
        subscribe()
    }
    
    // 向 NotificationCenter 注册 self(this) 来接收所有存储在 notificationOfInterest 中的通知。
    // 当接收到任意一个注册的通知时，会调用 receiveNotification(_:) 方法。
    func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(_:)), name: notificationOfInterest, object: nil)
    }
    
    // 在不需要监听时注销所有已注册的通知是一个不错的做法，
    // 但这主要是由于历史原因造成的，iOS 9.0 之后 OS 系统会自动做一些清理。
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self, name: notificationOfInterest, object: nil)
    }
    
    // 在任意一个 notificationOfInterest 所定义的通知接收到时调用。
    // 在此方法中可以根据所观察的重要资源的改变进行任意操作。
    // 此方法**必须有且仅有一个参数（NSNotification 实例）。**
    @objc func receiveNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo, let status = userInfo[statusKey] as? String {
            
            statusValue = status
            handleNotification()
            
            print("Notification \(notification.name) received; status: \(status)")
            
        }
        
    } // receiveNotification 方法结束
    
    // **必须重写此方法；且必须继承此类**
    // 我使用了些"技巧"来让此类达到抽象类的形式，因此你可以在子类中做其他任何事情而不需要关心关于 NotificationCenter 的细节。
    func handleNotification() {
        fatalError("ERROR: You must override the [handleNotification] method.")
    }
    
    // 析构时取消对 Notification 的关联，此时已经不需要进行观察了。
    deinit {
        print("Observer unsubscribing from notifications.")
        unsubscribe()
    }
    
} // Observer 类结束

// 一个具体观察者的例子。
// 通常来说，会有一系列（许多？）的观察者都会监听一些单独且重要的资源发出的通知。
// 需要注意此类已经简化了实现，并且可以作为所有通知的 handler 的模板。
class NetworkConnectionHandler: Observer {
    
    var view: UIView
    
    // 你可以创建任意类型的构造器，只需要调用 super.init 并传入合法且可以配合 NotificationCenter 使用的通知。
    init(view: UIView) {
        
        self.view = view
        
        super.init(statusKey: .networkStatusKey, notification: .networkConnection)
    }
    
    // **必须重写此方法**
    // 此方法中可以加入任何处理通知的逻辑。
    override func handleNotification() {
        
        if statusValue == NetworkConnectionStatus.connected.rawValue {
            view.backgroundColor = UIColor.green
        }
        else {
            view.backgroundColor = UIColor.red
        }
        
    } // handleNotification() 结束
    
} // NetworkConnectionHandler 结束

// 一个被观察者的模板。
// 通常被观察者都是一些重要资源，在其自身某些状态发生改变时会广播通知给所有订阅者。
protocol ObservedProtocol {
    var statusKey: StatusKey { get }
    var notification: Notification.Name { get }
    func notifyObservers(about changeTo: String) -> Void
}

// 在任意遵循 ObservedProtocol 示例的某些状态发生改变时，会通知*所有*已订阅的观察者。
// **向所有订阅者广播**
extension ObservedProtocol {
    
    func notifyObservers(about changeTo: String) -> Void {
        NotificationCenter.default.post(name: notification, object: self, userInfo: [statusKey.rawValue : changeTo])
    }
    
} // ObservedProtocol 扩展结束
