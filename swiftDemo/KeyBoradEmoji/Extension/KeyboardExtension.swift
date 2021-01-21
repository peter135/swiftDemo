//
//  KeyboardExtension.swift
//  swiftDemo
//
//  Created by peter on 2019/1/21.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation

public protocol MYCompatible{
    
    associatedtype MYCompatibleType
    var my:MYCompatibleType {get}
    
}


public final class MYExtension<Base>:MYCompatible{
    
    public let my: Base
    public init(_ my:Base) {
        self.my = my
    }
}

public extension MYCompatible {
    public var my:MYExtension<Self>{
        return MYExtension(self)
    }
}


