//
//  IndicatorView.swift
//  swiftDemo
//
//  Created by peter on 2018/8/4.
//  Copyright © 2018 Fubao. All rights reserved.
//

import UIKit

class IndicatorView: RefreshView {
    
    lazy var arrowLayer: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 0, y: -8))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 5.66, y: 2.34))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: -5.66, y: 2.34))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.withAlphaComponent(0.8).cgColor
        layer.lineWidth = 2
        layer.lineCap = kCALineCapRound
        return layer
    }()

   let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
   override init(type: type, height: CGFloat, action: @escaping () -> Void) {
        super.init(type: type, height: height, action: action)
        layer.addSublayer(arrowLayer)
        addSubview(indicator)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        arrowLayer.position = center
        indicator.center = center
    }
    
    override func didUpdateState(_ isRefreshing: Bool) {
        arrowLayer.isHidden = isRefreshing
        isRefreshing ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    
    override func didUpdateProgress(_ progress: CGFloat) {
        let rotation = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
        if self.type == .header {
            arrowLayer.transform = progress == 1 ? rotation : CATransform3DIdentity
        } else {
            arrowLayer.transform = progress == 1 ? CATransform3DIdentity : rotation
        }
    }
    
}
