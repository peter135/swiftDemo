//
//  EmojiController.swift
//  swiftDemo
//
//  Created by peter on 2019/1/2.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation
import UIKit
import Photos
import RxSwift
import ReSwift

class EmojiController: BaseController,StoreSubscriber {
    
    //MARK: redux
    
    func newState(state: MessageState) {

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        messageStore.subscribe(self)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        messageStore.unsubscribe(self)

        
    }
    
    
    //MARK: lifeCycle
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let isAuthorized = PHPhotoLibrary.isAuthorized.share()
        
        isAuthorized
            .skipWhile { $0 == false }
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                //  [weak self]
                //  Reload the photo collection view
                //  if let `self` = self {
                //    self.photos = PhotoCollectionViewController.loadPhotos()
                //    self.collectionView?.reloadData()
                //  }
            })
            .disposed(by: bag)
        
        isAuthorized
            .distinctUntilChanged()
            .takeLast(1)
            .filter(!)
            .subscribe(onNext: { _ in
//                self.flash(title: "Cannot access your photo library",
//                           message: "You can authorize access from the Settings.",
//                           callback: { _ in
//                            self.navigationController?.popViewController(animated: true)
//                })
            })
            .disposed(by: bag)
        
        
        
    }
    
    
    
    
    
}
