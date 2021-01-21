//
//  AppDelegate.swift
//  swiftDemo
//
//  Created by Fubao on 2018/7/20.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import UIKit
//import LifetimeTracker

let MainNavBarColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kTabBarHeight = 49
let kNavBarHeight = 49


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate,RootTabBarDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //
        
//        _ = AppDelegateFactory.makeDefault()
        
        _ = AppLifeCycleMediator.makeDefaultMediator()
        
        
        //  StartupCommandsBuilder()
        //   .setKeyWindow(window!)
        //   .build()
        //   .forEach{$0.execute()}
        
        
        //        #if DEBUG
        //        LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration(visibility: .alwaysVisible, style: .bar).refreshUI)
        //        #endif
        
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white


        UIButton.methondExchange()
        
        //
        //UIViewController.presentChange()
        
        //配置tabbar
        let tabBarNormalImages = ["basket_n","foot_n","home_n","mine_n"]
        let tabBarSelectedImages = ["basket_h","foot_h","home_h","mine_h"]
        let tabBarTitles = ["首页","消息","功能","我的"]
        
        let tabController = UITabBarController()
        
        
        
        let dataFormat = ["key1":"1行",
                          "key2":"2行",
                          "image":"https://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
        
        var dataArray:[[String:Any]] = []
        
        for _ in 0...10 {
            
            dataArray.append(dataFormat)
            
        }
        
//        let controller = TableController(data:dataArray)
        
        let controllers:[UIViewController] = [TableController(data:dataArray,isAsync:true),TableController(data: dataArray, isAsync: false),ViewController(),SliderController()]
        
        for index in 0..<tabBarTitles.count{
            
            let vc = controllers[index]
            
            let barItem = UITabBarItem.init(title: tabBarTitles[index],
                                            image: UIImage.init(named: tabBarNormalImages[index])?.withRenderingMode(.alwaysOriginal),
                                            selectedImage: UIImage.init(named: tabBarSelectedImages[index])?.withRenderingMode(.alwaysOriginal))
            
            //2.更改字体颜色
            barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .normal)
            barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.red], for: .selected)
            
            //设置标题
            vc.title = tabBarTitles[index]
            
            //设置根控制器
            vc.tabBarItem = barItem
            
            let root = BaseNavigationController.init(rootViewController: vc)
            root.setNavigationBarHidden(true, animated: false)
            
            tabController.addChildViewController(root)
            

            
        }
        
        let tab = RootTabBar()
        tab.midBtndelegate = self
        tabController.setValue(tab, forKey: "tabBar")

        
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func midBtnClick() {
       
        let waterFall = WaterFallController()
        
        let tabController = UIApplication.shared.keyWindow?.rootViewController
        
        tabController?.present(waterFall, animated: true, completion: nil)

        
        
    }
    
    
    
}



