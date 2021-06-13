//
//  Box.swift
//  swiftDemo
//
//  Created by apple on 2021/5/30.
//  Copyright © 2021 Fubao. All rights reserved.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener:Listener?
    
    var value:T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(listener:Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}



