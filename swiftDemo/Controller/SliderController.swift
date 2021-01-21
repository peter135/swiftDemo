//
//  SliderController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/15.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit


class MyScroller:UIScrollView,UIGestureRecognizerDelegate {
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
//        print("\(gestureRecognizer)")
//
//        print("\(otherGestureRecognizer)")
        
        if  otherGestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self){
            
            let location = gestureRecognizer.location(in: self)
            print("location \(location.x)")
            
            
            if((Int(location.x) % Int(kScreenWidth)) < 30){
                return true
                
            }
            
        
        }
        
        
        return false
        
        
    }
    
    open  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //        print("\(gestureRecognizer.classForCoder)")
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self){
            
            let location = gestureRecognizer.location(in: self)
//            print("location \(location.x)")
            
            let state = gestureRecognizer.state
            if(state == .began || state == .possible){
            
            
            if((Int(location.x) % Int(kScreenWidth)) < 30){
                
                return false
                
            }
                
            }
            
        }
        
        
        return true
    }
    
    
}


class SlideMenu: UIView {
    
    private var data:[String] = []
    
    public var block:((Int) -> Void) = {_ in
        
    }
    
    private var selectedIndex = -1 {
        
        didSet{
            
//            if (oldValue == selectedIndex) {
//
//                return
//            }
//
            let btnOld = self.viewWithTag(oldValue+100) as? UIButton
            
            btnOld?.isSelected = false
            
            let btn = self.viewWithTag(selectedIndex+100) as? UIButton
            
            btn?.isSelected = true
            
            
        }
        
    }
    
    init(data:[String],frame: CGRect) {
        
        self.data = data
        super.init(frame: frame)
        
        self.loadViews()
        
    }
    
    
    func loadViews() {
        
        let count = CGFloat(self.data.count)
        
        for (index,string) in self.data.enumerated() {
            
            let btn = UIButton()
            btn.frame = CGRect(x: kScreenWidth/count * CGFloat(index), y: 0, width: kScreenWidth/count, height: 44)
            btn.tag = index + 100
            btn.setTitle(string, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.blue, for: .selected)
            btn.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
            self.addSubview(btn)
            
        }
        
        
        
    }
    
    
    @objc func click(btn:UIButton){
        
        let tag = btn.tag
        
        self.block(tag-100)
        
    }
    
    
    func setSelectedIndex(index:Int){
        
        self.selectedIndex = index
        
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder has not been implemented")
        
    }
    
    
}

class SliderController: BaseController,UIScrollViewDelegate {
    
    let pageMenuHeight:CGFloat = 44.0
    
    private var beginContentOffset:CGFloat = 0.0

    var viewSet:Set<Int> = []
    
    var slideMenu:SlideMenu!
    
    
    var currentPage:Int = 0 {
        
        didSet{
            
//            print("currentPage \(currentPage)")
            
            
            guard currentPage>=0 && currentPage<self.controllers.count else {
                return
            }
            
            if abs(currentPage - oldValue) > 1 {
                
                  container.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: false)
            }
            
            container.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
                
            slideMenu.setSelectedIndex(index: currentPage)
            
            let targetViewController = self.controllers[currentPage];
            
            // 如果已经加载过，就不再加载
            
            if viewSet.contains(currentPage){
                
                print("viewSet \(viewSet)")
                return

                
            }else{
                
                viewSet.insert(currentPage)

            }
            
//            if (targetViewController.isViewLoaded) {
//                return
//
//            }
            
            let height = container.bounds.size.height
            
            targetViewController.view.frame = CGRect(x: kScreenWidth * CGFloat(currentPage), y: 0, width: kScreenWidth, height: height)
            container.addSubview(targetViewController.view)
            

        }
        
    }
    
    private lazy var container:MyScroller = {
        
        let containerLazy = MyScroller()
        containerLazy.delegate = self
        containerLazy.frame = CGRect(x: 0, y: pageMenuHeight*2, width: kScreenWidth, height: kScreenHeight - pageMenuHeight*2 - 49)
        containerLazy.bounces = true
        
        return containerLazy
        
    }()
    
    private lazy var controllers:[UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        slideMenu = SlideMenu(data: ["上海","杭州","宁波"], frame: CGRect(x: 0, y: 44, width: Int(kScreenWidth), height: 44))
        slideMenu.setSelectedIndex(index:0)
        slideMenu.block = { [weak self] (index)->Void in
            
            self?.currentPage = index
            
        }

        self.view.addSubview(slideMenu)

        self.view.addSubview(container)
        
        let dataFormat = ["key1":"1行",
                          "key2":"2行",
                          "image":"https://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
        
        var dataArray:[[String:Any]] = []
        
        for _ in 0...10 {
            
            dataArray.append(dataFormat)
            
        }
        
        let controller1 = SlideChildController()
        controller1.container.backgroundColor = .red
        
        let controller2 = SlideChildController()
        controller2.container.backgroundColor = .green

        let controller3 = SlideChildController()
        controller3.container.backgroundColor = .blue

        
        self.controllers = [controller1,controller2,controller3]
        
        
        for controller in self.controllers {
            
            self.addChildViewController(controller)
        }
        
        self.container.addSubview(self.controllers[0].view)
        
        let controllerCount = self.controllers.count
        
        self.container.contentSize = CGSize(width: kScreenWidth*CGFloat(controllerCount), height: kScreenHeight-pageMenuHeight*2 - 49)
        self.container.isPagingEnabled = true
        
        
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")

    }
    
    deinit {
        
    
        
    }
    
    
}

extension SliderController:UIGestureRecognizerDelegate{
    
    

}

extension SliderController{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let contentOffsetX = scrollView.contentOffset.x

//        print("contentOffsetX \(contentOffsetX)")
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        beginContentOffset = kScreenWidth*CGFloat(currentPage)
        
//        print("beginContentOffset \(beginContentOffset)")

        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging \(decelerate)")
        
        if !decelerate {
            
            //不减速
            self.adjustOffset(scrollView: scrollView)

        }
        
    }
    
    //开始减速
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDecelerating")

        
    }
    
    //减速停止
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("scrollViewDidEndDecelerating")

        self.adjustOffset(scrollView: scrollView)

    }
    
    
    func adjustOffset(scrollView:UIScrollView) {
        
        let contentOffsetX = scrollView.contentOffset.x
        
        let offset = contentOffsetX - beginContentOffset
        
        //右滑,超过一半
        if offset>0 && offset >= kScreenWidth*0.5 {
            
            currentPage += 1
            return
            
        }
        
        //右滑，小于一半
        if offset>0 && offset < kScreenWidth*0.5 {
            
            let newPage = currentPage
            
            currentPage = newPage
            
            return
            
        }
        
        //左滑,超过一半
        if offset<0 && -offset >= kScreenWidth*0.5 {
            
            currentPage -= 1
            return
            
        }
        
        //右滑，小于一半
        if offset<0 && -offset < kScreenWidth*0.5 {
            
            let newPage = currentPage
            
            currentPage = newPage
            
            return
            
        }
        
    }
    
    
}
