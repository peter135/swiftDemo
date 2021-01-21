//
//  Struct.swift
//  swiftDemo
//
//  Created by peter on 2018/10/24.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct Track {
    var title:String
    var audioURL:URL
    
}

class TrackViewController: UIViewController {
    
    var player:AVPlayer?
    
    var track:Track?{
        
        willSet{
            self.player?.pause()
        }
        
        didSet{
            
            guard let track = self.track else {
                return
            }
            
            self.title = track.title
            
            let item = AVPlayerItem(url: track.audioURL)
            self.player = AVPlayer(playerItem: item)
            self.player?.play()
            
        }
        
    }
    
}

struct NormalizedText{
    
    enum Error:Swift.Error{
        
        case empty
        case excessiveLength
        case unsupportedCharecters
        
    }
    
    static let maximumLength = 32
    
    var value:String
    
    init(_ string:String) throws {
        
        if string.isEmpty{
            throw Error.empty
            
        }
        
        
        
        if #available(iOS 9.0, *) {
            guard let value = string.applyingTransform(.stripDiacritics, reverse: false)?.uppercased(),value.canBeConverted(to: .ascii)else{
                
                throw Error.unsupportedCharecters
                
            }
            
            guard value.count < NormalizedText.maximumLength else {
                
                throw Error.excessiveLength
            }
            
            self.value = value
        
            
            
        } else {
            
            
            // Fallback on earlier versions
            self.value = ""
            
        }
        
  
        
        
    }
    
    
    
    
}

struct  Work:Codable {
   
    var height = 180
    
    var color = "yellow"
    
    //初始化方法
    init(height:Int,color:String) {
        
        self.height = height
        self.color = color
        
    }
    
    init(height:Int) {
        
        self.init(height: height,color:"red")
    }
    
    
    func printSelf(){
        
        print("my height is \(height) color is \(color)" )
    }
    
    //修改属性（值类型）
    mutating func setColor(newColor:String){
        
        color = newColor
    }
    
    //static 类方法
    static func getNumberOfWorker()->Int{
        
        return 5
    }
    
}

//var woker = Work()

var worker1 = Work(height: 181, color: "blue")


