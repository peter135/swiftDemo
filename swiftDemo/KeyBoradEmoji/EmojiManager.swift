//
//  File.swift
//  swiftDemo
//
//  Created by peter on 2019/1/11.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation

class EmojiPackageModel {
    
    var emojiPackageName:String?
    var emojis:Array<EmojiModel>?
    var isSelceted:Bool = false
    
}

class EmojiModel{
    
    var imageName:String?
    var emojiDescription:String?
    
}

class MatchingEmojiManager{
    

    static let share = MatchingEmojiManager()
    
    private init(){
        
        
    }
    
    
    private(set) var allEmojiPack = Array<EmojiPackageModel>()
    private func getAllEmoji(){
        
        let bundle = Bundle.init(for: EmojiKeyboardView.self)
        guard let url = bundle.url(forResource: "MYKeyboardBundle", withExtension: "bundle") else  {
            
            return
            
        }
        
        let fileBundle = Bundle.init(url:url)
        guard let path = fileBundle?.path(forResource: "KeyboardEmojiInfo", ofType: "plist") else {
            
            return
            
        }
        
        let array = NSMutableArray.init(contentsOfFile: path)
        
        allEmojiPack = (array?.map{(packInfo)-> EmojiPackageModel in
            
            var info = packInfo as! Dictionary<String,Any>
            
            let packModel = EmojiPackageModel()
            packModel.emojiPackageName = info["packagename"] as? String
            
            let emojiArray = info["emoticons"] as! Array<Any>
            packModel.emojis = emojiArray.map{(packInfo)->EmojiModel in
                var emojiDict = packInfo as! Dictionary<String,String>
                let emojiModel = EmojiModel()
                emojiModel.imageName = emojiDict["image"]
                emojiModel.emojiDescription = emojiDict["desc"]
                
                return emojiModel
            }
            
                return packModel
            })!
        
    }
    
    let MYAddEmojiTag : String = "MYEmojiTextGeneralTag"

    public func exchangePlainText(_ attribute:NSAttributedString!) -> String?{
        
        let range = NSRange(location: 0, length: attribute.length)
        if range.location == NSNotFound || range.length == NSNotFound {
            return nil
        }
        
        var result = ""
        if range.length == 0 {
            return result
        }
        
        let string = attribute.string as NSString
        
        attribute.enumerateAttribute(NSAttributedString.Key(rawValue: MYAddEmojiTag), in: range, options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired){(value,range,stop) in
            
            if value != nil {
                let tagString = value as! String
                result = result + tagString
                
            }else{
                
                let rangString = string.substring(with: range)
                result = result + rangString
                
            }

        }
        
        return result
        
        
    }
    
    
    
    
}

