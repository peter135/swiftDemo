//
//  Department.swift
//  swiftDemo
//
//  Created by peter on 2018/12/25.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation

class Department:NSObject {
    
    var departmentId:Int
    var departmentChnm:String
    var departmentEnnm:String
    
    init(departmentId:Int, departmentChnm:String, departmentEnnm:String) {
        self.departmentId = departmentId
        self.departmentChnm = departmentChnm
        self.departmentEnnm = departmentEnnm
        
    }
    
    
    
}
