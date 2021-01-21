//
//  AppCommand.swift
//  swiftDemo
//
//  Created by peter on 2018/12/26.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation
import UIKit

protocol Command {
    
    func execute()
    
}

struct InitialThirdPartiesCommand:Command {
    
    func execute() {
        
        
    }
    
}

struct InitialViewControllerCommand:Command {
    
    let keyWindow:UIWindow
    
    init(_ window:UIWindow) {
        
        keyWindow = window
        
    }
    
    func execute() {
        
        keyWindow.rootViewController = UIViewController()
        
    }
    
}

final class StartupCommandsBuilder {
    
    private var window:UIWindow!
    
    func setKeyWindow(_ window:UIWindow) -> StartupCommandsBuilder{
        
        self.window = window
        
        return self
        
    }
    
    func build() -> [Command]{
        
        return [
            
            InitialThirdPartiesCommand(),
            InitialViewControllerCommand(window)
            
        ]
    }
    
    
    
    
}
