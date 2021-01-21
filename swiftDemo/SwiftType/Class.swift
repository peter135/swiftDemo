//
//  Class.swift
//  swiftDemo
//
//  Created by peter on 2018/10/24.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

class Person {
    
    //属性监听，lazy var
    var height = 170{
        
        willSet(newHeight){
            
        }
        
        didSet(oldHeight){
            
        }
        
        
    }
    
    var color = "yellow"
    
    //初始化方法
    init(height:Int,color:String) {
        
        self.height = height
        self.color = color
        
        
    }
    
    init?(height:Int) {
        
        guard height<190 else {
            return nil
        }
        
        self.height = height
        
        
    }
    
    
    func printSelf(){
        
        print("my height is \(height) color is \(color)")
        
    }
    
    
     func someMethod(cloure:()->Void){
        
        print("call someMethod")
        cloure()

    }
    
    
    
}

class Worker: Person {
    
    
    var workYears = 10
    
    var job = "医生"
    
    var person1 = Person(height: 170, color: "blue")
    
    
    //required intit(子类必须实现)
    init(years:Int,job:String,height:Int,color:String) {
        self.workYears = years
        self.job = job
        
        super.init(height: height, color: color)
        
    }
    
    //便捷初始化
    convenience init(job:String){
        
        self.init(years: 10, job: job, height: 170, color: "yellow")
        
    }
    
    
    override func printSelf(){
        
        print("my job is \(job) workYears is \(workYears)")
        
        super.printSelf()
        

        
    }
    
    
    func callClourse() {
        
        person1.someMethod{
            
            person1.height = 178
            
        }
        
    }
    
    func decodeJson() {
        
        
        let jsonString = "{\"color\":\"swift\",\"height\":181}"
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let result = try? decoder.decode(Work.self, from: jsonData)
        print(result as Any)  // 输出： Person(name: "swift", gender: "female", age: 22)
        
    }
    
    
    func codeJson()  {
        
        let work1 = Work(height: 175, color: "yellow")
        
        let encoder = JSONEncoder()
        
        let data = try! encoder.encode(work1)
        
        let encodeString = String(data: data, encoding: .utf8)!
        
        print(encodeString)
        
    }
    
    //类方法（static)
    class func getParentClassName() -> String {
        
        
        return "Person"
    }
    
    
    //
    deinit {
        
        
    }
    
    
    
}




