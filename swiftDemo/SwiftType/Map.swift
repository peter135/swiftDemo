//
//  Map.swift
//  swiftDemo
//
//  Created by peter on 2018/10/29.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation


protocol Container {
    
    associatedtype ItemType
    
    mutating func append(_ item:ItemType)
    
    var count:Int {get}

    subscript(i:Int) -> ItemType {get}
    
}

struct Stack<Element>:Container {
    
    var items = [Element]()
    
    mutating func push(_ item:Element){
        
        items.append(item)
    }
    
    mutating func pop() -> Element{
        
        return items.removeLast()
    }
    
    mutating func append(_ item: Stack<Element>.ItemType) {
        
        self.push(item)
    }
    
    
    var count: Int {
        
        return items.count
    }
    
    subscript(i:Int) -> Element {
        
        return items[i]
    }
    
}




protocol WorkP {
    
    associatedtype T
    
    func run() -> T
    func eat() -> T


}

class Map:WorkP {
    

    var array:[(Int,String)] = [(10,"PENNEY"),(15,"NICKLE"),(3,"QUATER")]
    
    var dict:[String:(Int,String)] = ["penny":(10,"PENNEY"),"nickle":(15,"NICKLE"),"quater":(3,"QUATER")]
    
    
    func run(){
        
        print("run \(array)")
//        return self
        
    }
    
    func eat(){
        
        print("eat \(dict)")
//        return self
        
    }
    
    
   class func stringLength(_ arrayString:[String]){
        
        print("stringLength \(arrayString)")

        
    }
    
    
    class func constructStack(){
        
        var tos = Stack<String>()
        
        tos.push("google")
        tos.push("apple")
        tos.push("taobao")

        print("\(tos.items)")
        
    }
    
    
    
}




