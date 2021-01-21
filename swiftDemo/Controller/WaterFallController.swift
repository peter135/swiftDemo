//
//  WaterFallController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/19.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

import UIKit

@objc protocol WaterFlowLayoutDataSoure:class{
    
    func waterfallLayoutForHeight(_ layout: WaterFlowLayout, indexPath: IndexPath) -> CGFloat

}


class WaterFlowLayout: UICollectionViewFlowLayout {
    
    var col:CGFloat = 3

    weak var dataSource: WaterFlowLayoutDataSoure?

    private var arrayAttribute:[UICollectionViewLayoutAttributes]=[UICollectionViewLayoutAttributes]()
    
    private lazy var colHeight: [CGFloat] = Array(repeatElement(self.sectionInset.top, count: Int(self.col)))


    override init() {
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        
    }
    
    override func prepare() {
        
//        print("prepare")
        
        arrayAttribute.removeAll()
        arrayAttribute = []
        
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        let cellWidth = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - CGFloat(col-1)*minimumInteritemSpacing)/col
        var cellHeight:CGFloat = 0
        var cellX:CGFloat = 0
        var cellY:CGFloat = 0

        for i in 0..<itemCount{
            
            let indexPath = IndexPath(item: i, section: 0)
            let attr:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            cellHeight = dataSource?.waterfallLayoutForHeight(self, indexPath: indexPath) ?? 0
            let minH = colHeight.min()!
            let minIndex = colHeight.index(of:minH)!
            
            cellX = sectionInset.left + CGFloat(minIndex) * (cellWidth + minimumInteritemSpacing)
            cellY = minH
            
            attr.frame = CGRect(x: cellX, y: cellY, width: cellWidth, height: cellHeight)
            
            colHeight[minIndex] = attr.frame.maxY + minimumLineSpacing
            arrayAttribute.append(attr)
            
            
        }
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
//        print("layoutAttributesForElements")

        return arrayAttribute
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: colHeight.max()! + sectionInset.bottom - minimumLineSpacing)
    }
    
    
}

class WaterFallCell: UICollectionViewCell {
    
    var label:UILabel = UILabel()
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        loadViews()
        
    }
    
    
    func loadViews(){
        
        self.label.textColor = .white
        self.label.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(label)
        self.label.snp.makeConstraints { (ConstraintMaker) in
        
            ConstraintMaker.center.equalTo(self)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class WaterFallController: UIViewController{
    
    private lazy var colletionView:UICollectionView = {
        
        let flowLayout = WaterFlowLayout()
        flowLayout.dataSource = self
        flowLayout.col = 3
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1

        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
        collection.backgroundColor = .white
        collection.register(WaterFallCell.classForCoder(), forCellWithReuseIdentifier: "registerCell")
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
        
    }()
    
    override func viewDidLoad() {
        
        self.view.addSubview(colletionView)
        
        
    }
    
}

extension WaterFallController:WaterFlowLayoutDataSoure{
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let indexH = CGFloat(indexPath.row*10 + 120)
//
//        return CGSize(width: (kScreenWidth-30)/2, height: indexH)
//
//    }
    
    func waterfallLayoutForHeight(_ layout: WaterFlowLayout, indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 || indexPath.row == 3 {
            
            return 40
            
        }
        
        return CGFloat(indexPath.row*10 + 120)
        
    }
    
}


extension WaterFallController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("indexPath \(indexPath)")
        
        if (indexPath.row == 4){
            
            dismiss(animated: true, completion: nil)

        }

    }
    
}

extension WaterFallController:UICollectionViewDataSource{
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "registerCell", for: indexPath) as! WaterFallCell
        cell.label.text = String(indexPath.row)
        cell.backgroundColor = .red
        
        return cell
        
    }
    
    
    
    
    
}
