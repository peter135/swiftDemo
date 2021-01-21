//
//  LoadingView.swift
//  swiftDemo
//
//  Created by peter on 2018/11/21.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func loadText(text:String) {
        
        let loading = LoadingView(view: self, text: text, image: nil, indicator: false)
        
        self.addSubview(loading)
        
        loading.snp.makeConstraints { (ConstraintMaker) in
            
            ConstraintMaker.height.equalTo(40)
            ConstraintMaker.center.equalTo(self)
            ConstraintMaker.width.lessThanOrEqualTo(120).priority(.high)

        }
        
        self.bringSubview(toFront: loading)
        
        
    }
    
    
    func dismissLoading(){
        
        let loading = self.viewWithTag(self.hash)

        if loading != nil {
            
            loading!.removeFromSuperview()

        }
        
        
    }
    
    
}




class LoadingView: UIView {
    
    private var indicator = UIActivityIndicatorView()
    private var text = UILabel()
    private var image = UIImageView()

    private var imageHidden = true
    private var indicatorHidden = false
    private var textHidden = false

    
    init(view:UIView,text:String?,image:String?,indicator:Bool){
        
        super.init(frame: .zero)

        loadSubViews()
        
        self.tag = view.hash

        //文字
        if text == nil {
            textHidden = true
        }
        self.text.isHidden = textHidden
        self.text.text = text

    
        //小菊花
        indicatorHidden = indicator
        self.indicator.isHidden = indicatorHidden
        self.indicator.startAnimating()
        
        //图片
        if image != nil {
            
            imageHidden = false
            self.image.image = UIImage.init(named: image!)

        }
        
        
    }
    
    func loadSubViews() {
        
        backgroundColor = UIColor(white: 0, alpha: 1.0)
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.addSubview(self.indicator)
        
        self.text.font = UIFont.systemFont(ofSize: 14)
        self.text.textColor = .white
        self.addSubview(self.text)
        
        self.addSubview(self.image)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("required init has not implemented")
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if !indicatorHidden {
            
            indicator.snp.makeConstraints { (ConstraintMaker) in
                
                ConstraintMaker.width.equalTo(30)
                ConstraintMaker.height.equalTo(30)
                ConstraintMaker.left.equalTo(self).offset(10)
                ConstraintMaker.centerY.equalTo(self)
                
            }
            
            
        }
        

        if !imageHidden {
            
            image.snp.makeConstraints { (ConstraintMaker) in
                
                ConstraintMaker.width.equalTo(30)
                ConstraintMaker.height.equalTo(30)
                ConstraintMaker.left.equalTo(self).offset(10)
                ConstraintMaker.centerY.equalTo(self)
                
            }
            
            
        }
        
        
        text.snp.makeConstraints { (ConstraintMaker) in
            
            ConstraintMaker.right.equalTo(self).offset(-10)
            ConstraintMaker.centerY.equalTo(self)

            if( imageHidden && indicatorHidden){
                
                ConstraintMaker.left.equalTo(self).offset(10)

            }else{
                
                ConstraintMaker.left.equalTo(self).offset(50)

            }

            
            
        }
    
        
        
        
        
    }
    
}

