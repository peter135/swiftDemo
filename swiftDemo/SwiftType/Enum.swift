//
//  Enum.swift
//  swiftDemo
//
//  Created by peter on 2018/10/24.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation


enum  TextColor{
    
    case blue
    case black
    case green
    
    func getColorValue() -> Int {
        
        switch self{
            
            case .black:
                return 1
            case .blue:
                return 2
            case .green:
                return 3
            
        }
        
    }
    
    static func getTest(){
        
        print("\n test")
        
    }
    
    
}


enum Shape {
    
    case point
    case square(side:Double)
    case rectangle(width:Double,height:Double)
    
    func area() -> Double {
        
        switch self {
            case .point:
                return 0
            
            case let .square(side:s):
                return s*s
            
            case let .rectangle(width:w,height:h):
                return w*h
            
        }
        
    }
    
    
}
