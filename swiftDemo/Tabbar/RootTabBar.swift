//
//  RootTabBar.swift
//  swiftDemo
//
//  Created by peter on 2018/11/16.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

import UIKit

protocol RootTabBarDelegate:NSObjectProtocol{
    
    func midBtnClick()
    
}

class RootTabBar: UITabBar {
    
    weak var midBtndelegate:RootTabBarDelegate?
    
    private lazy var midBtn:UIButton = {
       return UIButton()
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        midBtn.setTitle("发布", for: .normal)
        midBtn.setTitleColor(.red, for: .normal)
        midBtn.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        midBtn.addTarget(self, action: #selector(RootTabBar.addButtonClick), for: .touchUpInside)
        /// 设置添加按钮位置

        self.addSubview(midBtn)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonClick(){
        if midBtndelegate != nil{
            midBtndelegate?.midBtnClick()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let btnWidth = kScreenWidth/5
        
        var index = 0
        
        for btn in self.subviews{
//            print("btn \(btn)")
            
            
            if btn.classForCoder == NSClassFromString("UITabBarButton") {
        
                let ctrl  = btn as! UIControl
                ctrl.addTarget(self, action: #selector(self.barBtn(sender:)), for: .touchUpInside)
                
                
                if index == 2{
                    midBtn.frame.size = CGSize.init(width: btnWidth, height: self.frame.size.height)
                    midBtn.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2)
                    
                    index += 1
                }
                
                btn.frame = CGRect.init(x: btnWidth * CGFloat(index), y: 0, width: btnWidth, height: self.frame.size.height)
                index += 1
         
            }
            
        }
        
        self.bringSubview(toFront: midBtn)

        
        
    }
    
    @objc func barBtn(sender:UIControl){
        
        for imageView in sender.subviews{
            
            if NSStringFromClass(imageView.classForCoder) == "UITabBarSwappableImageView" {
                
                self.tabBarAnimationWithView(view:imageView)
                
            }
            
        }
        
        
    }
    
    @objc func tabBarAnimationWithView(view:UIView){
        
        let scaleAnimation = CAKeyframeAnimation()
        scaleAnimation.keyPath = "transform.scale"
        scaleAnimation.values = [1.0,1.3,1.5,1.25,0.8,1.25,1.0]
        scaleAnimation.duration = 0.5
        scaleAnimation.calculationMode = kCAAnimationCubic
        scaleAnimation.repeatCount = 1
        view.layer.add(scaleAnimation, forKey: "123")

    }
    
    
    /// 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.midBtn)
            /// 判断新的点是否在按钮上
            if self.midBtn.point(inside: onButton, with: event){
                return midBtn
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
    
    
    
    
}
