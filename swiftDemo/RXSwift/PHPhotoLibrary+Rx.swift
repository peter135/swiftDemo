//
//  PHPhotoLibrary+Rx.swift
//  swiftDemo
//
//  Created by peter on 2019/1/29.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary{
    
    static var isAuthorized:Observable<Bool>{
        
        return Observable.create{ obeserve in
            
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    obeserve.onNext(true)
                    obeserve.onCompleted()
                } else {
                    requestAuthorization {
                        obeserve.onNext($0 == .authorized)
                        obeserve.onCompleted()
                    }
                }
            }
            return Disposables.create()
            
        }
        
        
    }
    
    
}


