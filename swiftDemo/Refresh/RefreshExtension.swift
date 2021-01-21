//
//  RefreshExtension.swift
//  swiftDemo
//
//  Created by peter on 2018/8/4.
//  Copyright © 2018 Fubao. All rights reserved.
//

import UIKit

private var headerKey: UInt8 = 0
private var footerKey: UInt8 = 0

extension UIScrollView {
    
    private var refresh_header:RefreshView?{
        get{
            return objc_getAssociatedObject(self, &headerKey) as? RefreshView
        }
        
        set{
            
            refresh_header?.removeFromSuperview()
            objc_setAssociatedObject(self, &headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map { insertSubview($0, at: 0) }

            
        }
    }
    
    
    private var refresh_footer:RefreshView?{
        
        get{
            return objc_getAssociatedObject(self, &footerKey) as? RefreshView
        }
        
        set {
            refresh_footer?.removeFromSuperview()
            objc_setAssociatedObject(self, &footerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map { insertSubview($0, at: 0) }
        }
        
    }
    
    public func refresh_setIndicatorHeader(height: CGFloat = 60,
                                       action: @escaping () -> Void) {
        refresh_header = IndicatorView(type:.header, height: height, action: action)
    }
    
    public func refresh_setIndicatorFooter(height: CGFloat = 60,
                                       action: @escaping () -> Void) {
        refresh_footer = IndicatorView(type: .footer, height: height, action: action)
    }
    
    /// Begin refreshing with header
    public func refresh_beginRefreshing() {
        refresh_header?.beginRefreshing()
        
    }
    
    /// End refreshing with both header and footer
    public func refresh_endRefreshing() {
        refresh_header?.endRefreshing()
        refresh_footer?.endRefreshing()
    }
    
}
