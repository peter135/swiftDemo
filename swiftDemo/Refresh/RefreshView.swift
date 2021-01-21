//
//  RefreshView.swift
//  swiftDemo
//
//  Created by peter on 2018/8/4.
//  Copyright © 2018 Fubao. All rights reserved.
//

import UIKit

class RefreshView: UIView {

    enum type {
        case header,footer
        
    }
    
    public  let type:type
    private let height:CGFloat
    private let action:()->Void
    
    public  init(type:type, height:CGFloat, action: @escaping ()->Void) {
        self.type = type
        self.height = height
        self.action = action
        super.init(frame:.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    //MARK
    private var isRefreshing = false {
        didSet {
            didUpdateState(isRefreshing)
        }
    }
    
    private var progress: CGFloat = 0 {
        didSet{
            didUpdateProgress(progress)
        }
    }
    
    private var scrollView: UIScrollView? {
        return superview as? UIScrollView
    }
    
    open func didUpdateState(_ isRefreshing: Bool){
        fatalError("didUpdateState(_:) has not been implemented")
    }
    
    open func didUpdateProgress(_ progress: CGFloat){
        fatalError("didUpdateProgress(_:) has not been implemented")
    }
    
    private var offset:NSKeyValueObservation?
    private var state:NSKeyValueObservation?
    private var contentSize:NSKeyValueObservation?

    open override func willMove(toSuperview newSuperview: UIView?) {
        
        guard  let superView = newSuperview else {
            
            offset?.invalidate()
            state?.invalidate()
            contentSize?.invalidate()
            
            return
        }
        
        guard let scrollView = superView as?  UIScrollView else {
            return
        }
        
        
        offset = scrollView.observe(\.contentOffset){[weak self] (obj, changed) in
            
            guard let `self` = self else {return}

            self.scrollViewDidScroll(obj)
            
        }
        
        state = scrollView.observe(\..panGestureRecognizer.state){[weak self] (obj, changed) in
            
            guard let `self` = self else {return}
            
            guard scrollView.panGestureRecognizer.state == .ended else {return}
            
            self.scrollViewDidEndDragging(obj)
            
        }
        
        if self.type == .header {
            frame = CGRect(x: 0, y: -height, width: UIScreen.main.bounds.width, height: height)
            
            return
        }
        
        contentSize = scrollView.observe(\.contentSize) { [weak self] scrollView, _ in
            guard let `self` = self else {return}

            self.frame = CGRect(x: 0, y: scrollView.contentSize.height, width: UIScreen.main.bounds.width, height: self.height)
            self.isHidden = scrollView.contentSize.height <= scrollView.bounds.height
            
        }
        
        
        
    }
    
    private func scrollViewDidEndDragging(_ scrollView:UIScrollView){
        
        if isRefreshing || progress < 1 {
            return
        }
        
        beginRefreshing()
        
    }
    
    func beginRefreshing() {
        
        guard let scrollView = scrollView, !isRefreshing else {
            
            return
        }
        
        progress = 1; isRefreshing = true
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                switch self.type {
                    
                case .header:
                    scrollView.contentOffset.y = -self.height - scrollView.contentInset.top
                    scrollView.contentInset.top += self.height
                    
                case .footer:
                    scrollView.contentInset.bottom += self.height
               
                }
            }, completion: { _ in
                self.action()
            })
        }
        
        
        
    }
    
    private func scrollViewDidScroll(_ scrollView:UIScrollView){
        
        if isRefreshing {return}
        
        switch self.type {
            case .header:
                progress = min(1, max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top) / height))
            case .footer:
                if scrollView.contentSize.height <= scrollView.bounds.height { break }
                 progress = min(1, max(0, (scrollView.contentOffset.y + scrollView.bounds.height - scrollView.contentSize.height - scrollView.contentInset.bottom) / height))
            
        }
        
        
    }
    
    func endRefreshing(completion: (() -> Void)? = nil) {
        guard let scrollView = scrollView else { return }
        guard isRefreshing else { completion?(); return }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                switch self.type {
                case .header:
                    scrollView.contentInset.top -= self.height
                case .footer:
                    scrollView.contentInset.bottom -= self.height
                }
            }, completion: { _ in
                self.isRefreshing = false
                self.progress = 0
                completion?()
            })
        }
    }

}
