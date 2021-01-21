//
//  Dao.swift
//  swiftDemo
//
//  Created by peter on 2018/12/25.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import FMDB

class  Dao: NSObject {
    
    static let shared = Dao()
    
    var fileName:String = "DEPARTMENT_DATA.sqlite"
    var filePath:String = ""
    var dataBase:FMDatabase!
    
    private override init() {
        super.init()
        
        self.filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + self.fileName
        
        print("filePath: \(self.filePath)")
        
    }
    
    deinit {
        print("deinit: \(self)")
    }
    

    // 创建table
    func createTable() {
        
        if !FileManager.default.fileExists(atPath: self.filePath){
            
            if self.openConnection(){
                
                let createTableSQL = """
                    CREATE TABLE DEPARTMENT (
                    DEPARTMENT_ID integer  NOT NULL  PRIMARY KEY DEFAULT 0,
                    DEPT_CH_NM Varchar(100),
                    DEPT_EN_NM Varchar(100))
                """
                self.dataBase.executeStatements(createTableSQL)
                
            }
            
        }
        
        
    }
    
    
    func openConnection() -> Bool {
        
        var isOpen = false
        
        self.dataBase = FMDatabase(path: self.filePath)
        
        if self.dataBase != nil {
            
            if self.dataBase.open(){
                
                isOpen = true
                
            }
            
        }
        
        return isOpen
    }
    
    //query data
    func queryData() -> [Department]{
        
        var departmentDatas:[Department] = []
        
        if self.openConnection() {
            
            let querySQL:String = "SELECT * FROM DEPARTMENT"
            
            do{
                let dataLists:FMResultSet = try dataBase.executeQuery(querySQL, values: nil)
                
                while dataLists.next(){
                    
                    let department: Department = Department(departmentId: Int(dataLists.int(forColumn: "DEPARTMENT_ID")), departmentChnm: dataLists.string(forColumn: "DEPT_CH_NM")!, departmentEnnm: dataLists.string(forColumn: "DEPT_EN_NM")!)
                    
                    departmentDatas.append(department)
                    
                }
                
            }catch{
                
                print(error.localizedDescription)
                
            }
            
        }
        
        
        return departmentDatas
        
    }
    
    /// 新增部門資料
    ///
    /// - Parameters:
    ///   - departmentEnglistName: 部門中文名稱
    ///   - departmentChineseName: 部門英文名稱
    func insertData(withDepartmentChineseName departmentChineseName: String, departmentEnglishName: String) {
        
        if self.openConnection() {
            let insertSQL: String = "INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPT_CH_NM, DEPT_EN_NM) VALUES((SELECT IFNULL(MAX(DEPARTMENT_ID), 0) + 1 FROM DEPARTMENT), ?, ?)"
            
            if !self.dataBase.executeUpdate(insertSQL, withArgumentsIn: [departmentChineseName, departmentEnglishName]) {
                print("Failed to insert initial data into the database.")
                print(dataBase.lastError(), dataBase.lastErrorMessage())
            }
            
            self.dataBase.close()
        }
    }
    
    /// 更新部門資料
    ///
    /// - Parameters:
    ///   - departmentId: 部門ID
    ///   - departmentEnglistName: 部門中文名稱
    ///   - departmentChineseName: 部門英文名稱
    func updateData(withDepartmentId departmentId: Int, departmentChineseName: String, departmentEnglistName: String) {
        if self.openConnection() {
            let updateSQL: String = "UPDATE DEPARTMENT SET DEPT_CH_NM = ?, DEPT_EN_NM = ? WHERE DEPARTMENT_ID = ?"
            
            do {
                try self.dataBase.executeUpdate(updateSQL, values: [departmentChineseName, departmentEnglistName, departmentId])
            } catch {
                print(error.localizedDescription)
            }
            
            self.dataBase.close()
        }
    }
    
    /// 刪除部門資料
    ///
    /// - Parameter departmentId: 部門ID
    func deleteData(withDepartmentId departmentId: Int) {
        if self.openConnection() {
            let deleteSQL: String = "DELETE FROM DEPARTMENT WHERE DEPARTMENT_ID = ?"
            
            do {
                try self.dataBase.executeUpdate(deleteSQL, values: [departmentId])
            } catch {
                print(error.localizedDescription)
            }
            
            self.dataBase.close()
        }
    }
    
    
    
    
}

