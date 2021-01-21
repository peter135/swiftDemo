//
//  Adapter.swift
//  swiftDemo
//
//  Created by peter on 2018/12/21.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation


// A dedicated adapter
struct iOSFile : AppDirectoryNames {
    let fileName: URL
    var fullPathInDocuments: String {
        return documentsDirectoryURL().appendingPathComponent(fileName.absoluteString).path
    }
    var fullPathInTemporary: String {
        return tempDirectoryURL().appendingPathComponent(fileName.absoluteString).path
    }
    var documentsStringPath: String {
        return documentsDirectoryURL().path
    }
    var temporaryStringPath: String {
        return tempDirectoryURL().path
    }
    
    init(fileName: String) {
        self.fileName = URL(string: fileName)!
    }
}

//let iOSfile = iOSFile(fileName: "myFile.txt")
//iOSfile.fullPathInDocuments
//iOSfile.documentsStringPath
//
//iOSfile.fullPathInTemporary
//iOSfile.temporaryStringPath
//
//// We STILL have access to URLs
//// through protocol AppDirectoryNames.
//iOSfile.documentsDirectoryURL()
//iOSfile.tempDirectoryURL()

// Protocol-oriented approach
protocol AppDirectoryAndFileStringPathNamesAdapter : AppDirectoryNames {
    
    var fileName: String { get }
    var workingDirectory: AppDirectories { get }
    
    func documentsDirectoryStringPath() -> String
    
    func tempDirectoryStringPath() -> String
    
    func fullPath() -> String
    
} // end protocol AppDirectoryAndFileStringPathAdpaterNames
extension AppDirectoryAndFileStringPathNamesAdapter {
    
    func documentsDirectoryStringPath() -> String {
        return documentsDirectoryURL().path
    }
    
    func tempDirectoryStringPath() -> String {
        return tempDirectoryURL().path
    }
    
    func fullPath() -> String {
        
        switch workingDirectory {
            
        case .Documents:
            return documentsDirectoryStringPath() + "/" + fileName
            
        case .Temp:
            return tempDirectoryStringPath() + "/" + fileName

        default:
            return tempDirectoryStringPath() + "/" + fileName

            
        
        }
    }
    
} // end extension AppDirectoryAndFileStringPathNamesAdpater
struct AppDirectoryAndFileStringPathNames : AppDirectoryAndFileStringPathNamesAdapter {
    
    let fileName: String
    let workingDirectory: AppDirectories
    
    init(fileName: String, workingDirectory: AppDirectories) {
        self.fileName = fileName
        self.workingDirectory = workingDirectory
    }
    
} // end struct AppDirectoryAndFileStringPathNames
//let appFileDocumentsDirectoryPaths = AppDirectoryAndFileStringPathNames(fileName: "myFile.txt", workingDirectory: .Documents)
//appFileDocumentsDirectoryPaths.fullPath()
//appFileDocumentsDirectoryPaths.documentsDirectoryStringPath()
//
//// We STILL have access to URLs
//// through protocol AppDirectoryNames.
//appFileDocumentsDirectoryPaths.documentsDirectoryURL()
//
//let appFileTemporaryDirectoryPaths = AppDirectoryAndFileStringPathNames(fileName: "tempFile.txt", workingDirectory: .Temp)
//appFileTemporaryDirectoryPaths.fullPath()
//appFileTemporaryDirectoryPaths.tempDirectoryStringPath()
//
//// We STILL have access to URLs
//// through protocol AppDirectoryNames.
//appFileTemporaryDirectoryPaths.tempDirectoryURL()
