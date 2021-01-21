//
//  WaveView.swift
//  swiftDemo
//
//  Created by peter on 2018/11/8.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import UIKit


class WaveView: UIView {
    
    public var amplitude:CGFloat = 8 {
        didSet{
            A = amplitude
        }
    }
    
    
    public var wavelength:CGFloat = 320
    
    public var speed:TimeInterval = 2
    
    public var waveColor = UIColor.black{
        
        didSet{
            waveShape.fillColor = waveColor.cgColor
            
        }
        
    }
    
    public var alwaysAnimation = false {
        didSet{
            
            if alwaysAnimation {
                
                startWave()
            }
        }
        
    }
    
    
    public var isWave: Bool {
        
        return !self.displayLink.isPaused
    }
    
    public func startWave() {
        
        guard !isWave else {
            
            return
        }
        self.displayLink.isPaused = false
        
    }
    
    
    //MARK: Private
    private var offsetX:CGFloat = 0;
    private var offsetY:CGFloat {return bounds.height - A}
    private var A:CGFloat = 8;
    
    
    private var waveShape: CAShapeLayer  = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.black.cgColor;
        shape.backgroundColor = UIColor.white.cgColor
        return shape
    }()
    
    private var displayLink = CADisplayLink()
    private var x:CGFloat = 0
    
    
    @objc private func drawWave(){
        
        let maxX = 2.0 * sqrt(amplitude)
        if x > maxX && !alwaysAnimation { //完成一个周期停止动画
            displayLink.isPaused = true
            A = amplitude
            offsetX = 0.0
            x = 0.0
            return
        }
        // y = 10 - (x - √10)^2 //振幅 A 周期公式 x∈(0,2*√10）；
        A = amplitude - pow((x - sqrt(amplitude)), 2)
        
        //计算波长
        let w = CGFloat((Double.pi) / Double(wavelength))
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0, y:bounds.height))
        for i in 0..<Int(bounds.width) {
            let x = CGFloat(i)
            let y = A * sin(w * CGFloat(i) + offsetX) + offsetY
            path.addLine(to: CGPoint.init(x: x, y: y))
        }
        path.addLine(to: CGPoint.init(x: bounds.width, y:bounds.height))
        path.close()

        waveShape.path = path.cgPath
        
        offsetX = offsetX + 0.1
//      print("x \(x) maxX \(maxX) offsetX\(offsetX)")

        
        if x >= maxX / 2 && alwaysAnimation { //持续动画时
            x = maxX / 2
            return;
        }
        x = x + maxX/(60 * CGFloat(speed)) //按秒计算一个周期时间
        
        
    }
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.initLayer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.initLayer()

    }
    
    
    func initLayer(){
        
        self.layer.addSublayer(self.waveShape)
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(drawWave))
        displayLink.isPaused = !alwaysAnimation;
        A = amplitude
        self.displayLink.add(to: RunLoop.current, forMode: .commonModes)
    
    }
    
    
    
    
}
