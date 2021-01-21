//
//  RXSwiftDemo.swift
//  swiftDemo
//
//  Created by peter on 2019/1/28.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift

enum viewLoadingStatus {
    case normal
    case loading
}

//MARK: State

struct MessageState:StateType {
    
    var newsList:[Int] = []
    var loadingState:viewLoadingStatus = .normal
    
}

//MARK: Store

let messageStore = Store<MessageState>(
    
    reducer:messageReducer,
    state:nil
)

//MARK: Action

struct ActionSetMessage: Action {
    var news: [Int] = []
}

/// 移除数据的Action
struct ActionRemoveMessage: Action {
    var index: Int
}

/// 改变视图的加载状态
struct ActionChangeLoading: Action {
    var loadingState: viewLoadingStatus
}

//MARK: Reducer

 func messageReducer(action: Action, state: MessageState?) -> MessageState {
    var state = state ?? MessageState()
    
    switch action {
        
        case let setMessage as ActionSetMessage:
            state.newsList = setMessage.news
        
        case let loading as ActionChangeLoading:
            state.loadingState = loading.loadingState
        
        case let remove as ActionRemoveMessage:
            state.newsList.remove(at: remove.index)
        
        default:
            break
    }
    
    return state
    
}


func messageRequest(state: MessageState, store: Store<MessageState>) -> Action? {
    
    print("ceshi")
    
    // 可以返回一个Action同时做一些操作，比如播放加载动画
    return ActionChangeLoading(loadingState: .loading)
    
    
}
