//
//  TextKitLabel.swift
//  swiftDemo
//
//  Created by peter on 2018/11/24.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit

class TextKitLabel: UILabel {
    
    /// 属性文本存储
    fileprivate lazy var textStorage = NSTextStorage()
    
    /// 负责文本“字形”布局
    fileprivate lazy var layoutManager = NSLayoutManager()
    
    /// 设定文本绘制范围
    fileprivate lazy var textContainer = NSTextContainer()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        prepareTextSystem()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareTextSystem()

    }
    
    override func drawText(in rect: CGRect) {
        
        let range = NSRange(location: 0, length: textStorage.length)
        
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textContainer.size = bounds.size
    }
    
    
    override  var text: String? {
        didSet{
            prepareTextContent()
        }
    }
    
    
    override  var attributedText: NSAttributedString? {
        didSet{
            prepareTextContent()
        }
    }
    
}


extension TextKitLabel{
    
    
    /// 准备文本系统
    func prepareTextSystem() {
        //1.准备文本内容
        prepareTextContent()
        //2.设置对象的关系
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        
    }
    
    
    /// 准备文本内容 - 使用textStorage 接管label 的内容
    func prepareTextContent() {
        
        if let attributedText = attributedText{
            textStorage.setAttributedString(attributedText)
            
        }else if let text = text{
            textStorage.setAttributedString(NSAttributedString(string: text))
            
        } else{
            textStorage.setAttributedString(NSAttributedString(string: ""))
            
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //1.获取用户点击的位置
        guard  let location = touches.first?.location(in: self) else {
            return
        }
        
        //获取当前点中字符的索引
        let index = layoutManager.glyphIndex(for: location, in: textContainer)
        
        print("烦我了,meidiandao \(index)")

        
//        //判断 index 是否子啊urlRanges 的范围内，如果在就高亮
//        for r in urlRanges ?? []{
//
//            if NSLocationInRange(index, r) {
//                print("选哟啊高亮")
//                //修改文本的字体属性
//                textStorage.addAttributes([NSForegroundColorAttributeName :UIColor.blue], range: r)
//                //如果需要重回，需要调用此方法
//                setNeedsDisplay()
//
//            }else{
//                print("烦我了,meidiandao")
//
//            }
//        }
        
        
    }
    
    
    
    
}
