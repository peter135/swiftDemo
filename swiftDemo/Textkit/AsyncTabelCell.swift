//
//  AsyncTabelCell.swift
//  swiftDemo
//
//  Created by peter on 2018/11/22.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol cellDelegate:NSObjectProtocol {
    
    func imageClick(index:Int)
    
    func linkClick()
    
}



class AsyncTableCell: UITableViewCell {
    
    
     weak var delegate:cellDelegate?
    
     var opeation:Operation = Operation()
     var isCanceled = false
     var data:[String:Any]?
     var taskArray:[RetrieveImageTask] = []
     var imageLayers:[CALayer] = []
     var imageRect:[CGRect] = []
    
    
    /// 属性文本存储
    fileprivate lazy var textStorage = NSTextStorage()
    
    /// 负责文本“字形”布局
    fileprivate lazy var layoutManager = NSLayoutManager()
    
    /// 设定文本绘制范围
    fileprivate lazy var textContainer = NSTextContainer()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTap(gesture:)))
        self.addGestureRecognizer(tap)
        
    }
    
    @objc func singleTap(gesture:UITapGestureRecognizer){
        
        print("single tap")
        
        let location = gesture.location(in: self)
        
        let locationFix = CGPoint(x: location.x-10, y: location.y-10)
        
        let index = layoutManager.glyphIndex(for: locationFix, in: textContainer)
        
        let linkRange = NSRange(location: 25, length: 8)
        
        if linkRange.contains(index) {
            
            print("single tap location \(index)")

            self.delegate?.linkClick()
            return
            

        }
        
        for (index,rect) in imageRect.enumerated() {
            
            if rect.contains(location){
                
                print("single tap location \(index)")
                
                self.delegate?.imageClick(index: index)
                break
                
            }
            
            
        }
        
        print("single tap location \(location)")

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    deinit {
        
        print("async cell deinit")
        
    }
    
    
    func clear(){
        
        for layer in imageLayers {
            
            layer.removeFromSuperlayer()
            
        }
        
        self.taskArray.removeAll()
        self.imageLayers.removeAll()
        self.layer.contents = nil
        
    }

    
    func  drawTextKit()  {
        
        
        //           let context = UIGraphicsGetCurrentContext();
        //            print("context \(context!)")
        
        if  self.isCanceled {
            print("text all cancelled")
            return
            
        }
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.lineSpacing = 5
        //          paragraph.lineBreakMode = .byCharWrapping
        //          paragraph.minimumLineHeight = 20
        
        if let string = self.data!["text"] {
            
            let attributeString = NSMutableAttributedString(string: string as! String)
            
            attributeString.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: attributeString.length))
            
            attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: 2) )
            attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 2, length: attributeString.length - 3) )
            
            attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 5, length: 3))
            attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 35, length: 3))
            
            let attachment = NSTextAttachment(data: nil, ofType: nil)
            let image = UIImage(imageLiteralResourceName: "Heart_red")
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: 0, width: 21, height: 21)
            
            let attachmentString = NSAttributedString(attachment: attachment)
            attributeString.insert(attachmentString, at: 5)
            
            
            let linkString = NSMutableAttributedString(string: "linkTest")
             linkString.addAttribute(.foregroundColor, value:UIColor.blue, range: NSRange(location: 0, length: linkString.length))
            linkString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: linkString.length))
            
            attributeString.insert(linkString, at: 25)

            
            
            //  |.usesDeviceMetrics|.truncatesLastVisibleLine
            //  计算文本高度
            //  let height = attributeString.boundingRect(with:CGSize(width: 200, height:CGFloat.greatestFiniteMagnitude ), options:.usesLineFragmentOrigin, context: nil).size.height
            
            
            if  self.isCanceled {
                print("text draw cancelled")
                return
                
            }
            
//            let option = NSStringDrawingOptions.truncatesLastVisibleLine.union(.usesLineFragmentOrigin)
            //                attributeString.draw(in: CGRect(x: 10, y: 10, width: 200, height: 80))
            
            textContainer.size = CGSize(width: 350, height: 160)
            textStorage.setAttributedString(attributeString)
            
            textStorage.addLayoutManager(layoutManager)
            layoutManager.addTextContainer(textContainer)
            
            
            let range = NSRange(location: 0, length: textStorage.length)
            layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint(x: 10, y: 10))
            
//            attributeString.draw(with: CGRect(x: 10, y: 10, width: 350, height: 160), options: option, context: nil)
            
            
        }
        
        
    }
    
    func  drawText()  {
        
        
        //           let context = UIGraphicsGetCurrentContext();
        //            print("context \(context!)")
        
        if  self.isCanceled {
            print("text all cancelled")
            return
            
        }
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.lineSpacing = 5
        //          paragraph.lineBreakMode = .byCharWrapping
        //          paragraph.minimumLineHeight = 20
        
        if let string = self.data!["text"] {
            
            let attributeString = NSMutableAttributedString(string: string as! String)
            
            attributeString.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: attributeString.length))

            attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: 2) )
            attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 2, length: attributeString.length - 3) )

            attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 5, length: 3))
            attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 35, length: 3))

            let attachment = NSTextAttachment(data: nil, ofType: nil)
            let image = UIImage(imageLiteralResourceName: "Heart_red")
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: 0, width: 21, height: 21)

            let attachmentString = NSAttributedString(attachment: attachment)
            attributeString.insert(attachmentString, at: 5)

            //  |.usesDeviceMetrics|.truncatesLastVisibleLine
            //  计算文本高度
            //  let height = attributeString.boundingRect(with:CGSize(width: 200, height:CGFloat.greatestFiniteMagnitude ), options:.usesLineFragmentOrigin, context: nil).size.height
            
            
            if  self.isCanceled {
                print("text draw cancelled")
                return
                
            }
            
            let option = NSStringDrawingOptions.truncatesLastVisibleLine.union(.usesLineFragmentOrigin)
            //                attributeString.draw(in: CGRect(x: 10, y: 10, width: 200, height: 80))
            attributeString.draw(with: CGRect(x: 10, y: 10, width: 350, height: 160), options: option, context: nil)
            
            
        }
        
        
    }
    
    func  drawImage()  {
        
        if  self.isCanceled {
            print("image download cancelled")
            return
            
        }
        
        for index in 0...5 {
            
            var x:Int = 10 , y:CGFloat = 180
            
            if index > 2 {
                y = 290
            }
            
            x = index > 2 ? (index-3)*110+10 :(index-0)*110+10
            
            let rect = CGRect(x: x, y: Int(y), width: 100, height: 100)
            imageRect.append(rect)

            
            guard let resource = URL(string: self.data!["image"+String(index+1)] as! String) else {
                
                return
            }
            
            let task =  KingfisherManager.shared.retrieveImage(with:resource ,
                                                               options: [],
                                                               progressBlock: nil,
                                                               completionHandler: {[weak self] image, error, cacheType, imageURL in
                                                                
                                                                if  self!.isCanceled  {
                                                                    print("image draw cancelled")
                                                                    return
                                                                    
                                                                }
                                                                
                                                                
                                                                guard let image = image else{
                                                                    return
                                                                }
                                                                
                                                                
                                                                
                                                                self?.setNeedsDisplay(CGRect(x: x, y: Int(y), width: 100, height: 100))
                                                                
//                                                                UIGraphicsGetCurrentContext()

                                                                image.draw(in: CGRect(x: x, y: Int(y), width: 100, height: 100))
                                                                
//                                                                let layer1 = CALayer()
//
//                                                                layer1.contents = image2.cgImage
//                                                                layer1.frame = CGRect(x: x, y: Int(y), width: 100, height: 100)
//                                                                self?.layer.addSublayer(layer1)
//
//                                                                self?.imageLayers.append(layer1)
                                                                
                                                                
                                                                
            })
            
            taskArray.append(task)
            
        }
        
        
    }
    
    //图片下载
    func  clearImageTask() {
        
        for task in taskArray {
            
            task.cancel()
            
        }
        
        
        for layer in imageLayers {
            
            layer.removeFromSuperlayer()
            
        }
        
        
        
    }
    
    //内存消耗大，性能好
    override func draw(_ rect: CGRect) {


        guard self.data != nil else {
            return
        }
        
        //
        UIGraphicsGetCurrentContext()

//        drawText()
        
        drawTextKit()

        drawImage()

    }
    
    
    //性能消耗大,内存小
    func displayAsync(){


//        DispatchQueue.global().async {

            //取消绘制

        if  self.isCanceled {
            print("cell task cancelled")
            return
            
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: kScreenWidth, height: 400), false, UIScreen.main.scale)
            
            drawText()
        
            drawImage()
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
        
//        print("异步绘制  \(Thread.current)")

        
        OperationQueue.main.addOperation({ () -> Void in
//            print("主线程  \(Thread.current)")
            
            if  self.isCanceled {
                print("cell layer cancelled")
                return
                
            }
            
            self.layer.contents = image?.cgImage

        })
            
    

         
//
//
//        }






    }
    
    
    func finishDraw()  {
        
        
     
        
        
        
    }
    
    
}


