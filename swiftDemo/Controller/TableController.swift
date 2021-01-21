//
//  TableController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/14.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
//import LifetimeTracker
import GTMRefresh

class TableCell: UITableViewCell {
    
    private var lable1:UILabel = UILabel()
    private var lable2:TextKitLabel = TextKitLabel()
    
    private var image1:UIImageView = UIImageView()
    private var image2:UIImageView = UIImageView()
    private var image3:UIImageView = UIImageView()
    private var image4:UIImageView = UIImageView()
    private var image5:UIImageView = UIImageView()
    private var image6:UIImageView = UIImageView()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.loadViews()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")

    }
    
    deinit {
        
        print("cell deinit")
        
    }
    
    
    private func loadViews() {
    
//        self.lable1.textColor = .black
//        self.lable1.font = UIFont.systemFont(ofSize: 14)
//        self.addSubview(lable1)
//        self.lable1.snp.makeConstraints { (ConstraintMaker) in
//
//            ConstraintMaker.left.equalTo(self).offset(15)
//            ConstraintMaker.top.equalTo(self).offset(10)
//
//        }
    
        
        
        lable2.textColor = .black
        lable2.font = UIFont.systemFont(ofSize: 14)
        lable2.numberOfLines = 0
        lable2.lineBreakMode = .byTruncatingTail
    
        addSubview(lable2)
        lable2.snp.makeConstraints { (ConstraintMaker) in
            
            ConstraintMaker.left.equalTo(self).offset(15)
            ConstraintMaker.top.equalTo(self).offset(10)
            ConstraintMaker.height.equalTo(160)
            ConstraintMaker.width.equalTo(350)

//            ConstraintMaker.top.equalTo(self.lable1.snp.bottom).offset(10)
//            ConstraintMaker.centerY.equalTo(self)

        }
    
    
        self.addSubview(image1)
        self.image1.snp.makeConstraints { (ConstraintMaker) in

            ConstraintMaker.left.equalTo(self).offset(10)
            ConstraintMaker.top.equalTo(lable2.snp.bottom).offset(10)
            ConstraintMaker.width.equalTo(100)
            ConstraintMaker.height.equalTo(100)

        }
    
        self.addSubview(image2)
        self.image2.snp.makeConstraints { (ConstraintMaker) in
        
            ConstraintMaker.left.equalTo(image1.snp.right).offset(10)
            ConstraintMaker.top.equalTo(lable2.snp.bottom).offset(10)
            ConstraintMaker.width.equalTo(100)
            ConstraintMaker.height.equalTo(100)
        
        }
    
        self.addSubview(image3)
        self.image3.snp.makeConstraints { (ConstraintMaker) in
        
            ConstraintMaker.left.equalTo(image2.snp.right).offset(10)
            ConstraintMaker.top.equalTo(lable2.snp.bottom).offset(10)
            ConstraintMaker.width.equalTo(100)
            ConstraintMaker.height.equalTo(100)
        
        }
    
        self.addSubview(image4)
        self.image4.snp.makeConstraints { (ConstraintMaker) in
        
            ConstraintMaker.left.equalTo(self).offset(10)
            ConstraintMaker.top.equalTo(image1.snp.bottom).offset(10)
            ConstraintMaker.width.equalTo(100)
            ConstraintMaker.height.equalTo(100)
        
        }
    
    self.addSubview(image5)
    self.image5.snp.makeConstraints { (ConstraintMaker) in
        
        ConstraintMaker.left.equalTo(image4.snp.right).offset(10)
        ConstraintMaker.top.equalTo(image1.snp.bottom).offset(10)
        ConstraintMaker.width.equalTo(100)
        ConstraintMaker.height.equalTo(100)
        
    }
    
    self.addSubview(image6)
    self.image6.snp.makeConstraints { (ConstraintMaker) in
        
        ConstraintMaker.left.equalTo(image5.snp.right).offset(10)
        ConstraintMaker.top.equalTo(image1.snp.bottom).offset(10)
        ConstraintMaker.width.equalTo(100)
        ConstraintMaker.height.equalTo(100)
        
    }
    
    
    }
    
    
    public func configForCell(data:[String:Any],index:Int){
    
//        let key1 = "\(index)"
//        let key2 = "\(index+1)"

//      self.lable1.text = key1
        
        if let string = data["text"] {
            
        let paragraph = NSMutableParagraphStyle()
            
        paragraph.lineSpacing = 5
            
        let attributeString = NSMutableAttributedString(string: string as! String)
        
        attributeString.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: attributeString.length))
        
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: 2) )
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 2, length: attributeString.length - 3) )
        
        attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 5, length: 3))
        attributeString.addAttribute(.foregroundColor, value:UIColor.red, range: NSRange(location: 35, length: 3))
        
        let attachment = NSTextAttachment(data: nil, ofType: nil)
        let image = UIImage(imageLiteralResourceName: "Heart_red")
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 21, height: 21)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        attributeString.insert(attachmentString, at: 5)
        
        self.lable2.attributedText = attributeString
        self.lable2.isUserInteractionEnabled = true
            
        }
    
        self.image1.kf.setImage(with:URL(string: data["image1"] as! String))
        self.image2.kf.setImage(with:URL(string: data["image2"] as! String))
        self.image3.kf.setImage(with:URL(string: data["image3"] as! String))
        self.image4.kf.setImage(with:URL(string: data["image4"] as! String))
        self.image5.kf.setImage(with:URL(string: data["image5"] as! String))
        self.image6.kf.setImage(with:URL(string: data["image6"] as! String))
        
    }
    
    
    
    
    
}




typealias RunloopBlock = () -> (Bool)

//MARK: Init
class TableController: BaseController {
    
    private var data:[[String:Any]]
    private var table:UITableView = UITableView()
    private var isAsync = false
    
    let backgroundQueue = DispatchQueue(label: "com.geselle.backgroundQueue", qos: .userInteractive)

    var queueDraw = OperationQueue()
    
    
    fileprivate let runLoopBeforeWaitingCallBack = {(ob: CFRunLoopObserver?, ac: CFRunLoopActivity) in
        
        print("runloop 循环完毕")
        
    }
    
    
    //runloop test
    fileprivate let useRunLoop = true
    
    fileprivate var runloopBlockArr:[RunloopBlock] = []
    
    fileprivate var maxQueueLength: Int = 2
    
    
    init(data:[[String:Any]],isAsync:Bool) {
        
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
        
        self.isAsync = isAsync
        
//        trackLifetime()


    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")

    }
    
    deinit {
        
        print("deinit \(self.classForCoder)")
    }
    
    
}


//MARK: View life
//:LifetimeTrackable

extension TableController{
    
//  static var lifetimeConfiguration = LifetimeConfiguration(maxCount: 1, groupName: "VC")

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
//        addTransition()
        
        self.addTable()
        let navBar = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
        navBar.backgroundColor = .red
        self.view.addSubview(navBar)
        
        self.addTableRefresh()
        
        //设置最大并发数
//      queueDraw.maxConcurrentOperationCount = 5
        
//        addRunloopObserver()
        
        
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        super.viewDidAppear(animated)
//        addTransition()
//
//
//    }
//
    

    
//    func addRunLoopObserver() {
//
//        let runloop = CFRunLoopGetCurrent()
//
//        let activities = CFRunLoopActivity.beforeWaiting.rawValue
//
//        let observer = CFRunLoopObserverCreateWithHandler(nil, activities, true, Int.max - 999, runLoopBeforeWaitingCallBack)
//
//        CFRunLoopAddObserver(runloop, observer, .defaultMode)
//
//    }
    
    /// 注册 Runloop 观察者
    fileprivate func addRunloopObserver() {
        // 获取当前的 Runloop
        let runloop = CFRunLoopGetCurrent()
        
        // 需要监听 Runloop 的哪个状态
        let activities = CFRunLoopActivity.beforeWaiting.rawValue
        // 创建 Runloop 观察者
        let observer = CFRunLoopObserverCreateWithHandler(nil, activities, true, 0) { [weak self] (ob, ac) in
            guard let `self` = self else { return }
            guard self.runloopBlockArr.count != 0 else { return }
            // 是否退出任务组
            var quit = false
            // 如果不退出且任务组中有任务存在
            while quit == false && self.runloopBlockArr.count > 0 {
                // 执行任务
                guard let block = self.runloopBlockArr.first else { return }
                // 是否退出任务组
                quit = block()
                // 删除已完成的任务
                let _ = self.runloopBlockArr.removeFirst()
            }
        }
        // 注册 Runloop 观察者
        CFRunLoopAddObserver(runloop, observer, .defaultMode)
        
    }
    
    /// 添加代码块到数组，在 Runloop BeforeWaiting 时执行
    ///
    /// - Parameter block: block description
    fileprivate func addRunloopBlock(block: @escaping RunloopBlock) {
        runloopBlockArr.append(block)
        // 快速滚动时，没有来得及显示的 cell 不会进行渲染，只渲染屏幕中出现的 cell
        if runloopBlockArr.count > maxQueueLength {
            let _ = runloopBlockArr.removeFirst()
        }
    }
    
    
    func addTable() {
        
        table = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64-49))
//        table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        
        if isAsync {
            table.register(AsyncTableCell.self, forCellReuseIdentifier: "tableCellAsync")

        }else{
            
            table.register(TableCell.self, forCellReuseIdentifier: "tableCellsync")

        }
        
//        table.contentSize = CGSize(width: kScreenWidth, height: 400*1000)
        
        table.rowHeight = 400
        
//        if #available(iOS 9.0, *) {
        
            self.table.estimatedRowHeight = 400
            self.table.estimatedSectionFooterHeight = 0
            self.table.estimatedSectionHeaderHeight = 0

//        }
        

        
        table.tableFooterView = UIView()
        table.reloadData()
        view.addSubview(table)
        
    }
    
    func addTableRefresh() {
        
        table.gtm_addRefreshHeaderView {
            [weak self] in
            
            print("refresh")
            self?.refresh()

        }
        
//        table.gtm_addLoadMoreFooterView {
//
//            [weak self] in
//
//            print("loadMore")
//            self?.loadMore()
//
//        }
        
        
        
        
        
    }
    
    func refresh() {
        perform(#selector(endRefresing), with: nil, afterDelay: 3)
    }
    
    @objc func endRefresing() {
        self.table.endRefreshing(isSuccess: true)
    }
    func loadMore() {
        perform(#selector(endLoadMore), with: nil, afterDelay: 3)
    }
    
    @objc func endLoadMore() {
        self.table.endLoadMore(isNoMoreData: true)
    }
    
    
    
}

extension TableController: UITableViewDataSource,cellDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
//      return data.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("cellForRowAt")

        let data = ["text":"是一篇论证严密、雄辩有力的说理散文。作者先列举六位经过贫困、挫折的磨炼而终于担当大任的人的事例，证明忧患可以激励人奋发有为，磨难可以促使人有新成就。接着，作者从一个人的发展和一个国家的兴亡两个不同的角度进一步论证忧患则生、安乐则亡的道理。最后水到渠成，得出“生于忧患，而死于安乐”的结论。全文采用列举历史事例和讲道理相结合的写法，逐层推论，使文章紧凑，论证缜密",
                    "image1":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990094&di=c2de7990be659e26ef7b62e8de713577&imgtype=0&src=http%3A%2F%2Fimages.ofweek.com%2FUpload%2FNews%2F2018-09%2F27%2Fzhouxiyao%2F1538009073437061091.jpg",
                    "image2":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990089&di=874604679cf5ba24eb419ce5d2914eb8&imgtype=0&src=http%3A%2F%2Fimg2.zol.com.cn%2Fproduct%2F192%2F812%2FceSvrQDdtXQOY.jpg",
                    "image3":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990089&di=650fb195a3b1b82c86b848f9fcf459a0&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Fbbd2f22c19be1aa1f7cc57069af714cf586724d6.jpg",
                    "image4":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990088&di=7b381cf7f44aedd816d972c11a7a90b1&imgtype=0&src=http%3A%2F%2F2.zol-img.com.cn%2Fproduct%2F192_640x2000%2F869%2FceJNindcw4E4.jpg",
                    "image5":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990088&di=1c761fd5b1e3b17e5eb1e8e9c42ef4a7&imgtype=0&src=http%3A%2F%2Fimg2.zol.com.cn%2Fproduct%2F192%2F439%2FcemQyj3j0IKxg.jpg",
                    "image6":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542877990087&di=ffb0f1d1e557df229af578444a4b36b5&imgtype=0&src=http%3A%2F%2Fdingyue.nosdn.127.net%2FnVTQD5Vkp3IQewCp%3DaUhROOfqdZdteqlXtEae1vLn2%3DCO1535694834796.jpg",]
        
        if isAsync {
            
            let cellAync = tableView.dequeueReusableCell(withIdentifier: "tableCellAsync") as! AsyncTableCell
//            cellAync.layer.contents = nil
            
            cellAync.selectionStyle = .none
            cellAync.data = data
            cellAync.delegate = self
//            cellAync.setNeedsDisplay()
            
//            addRunloopBlock { () -> (Bool) in
//
//                cellAync.selectionStyle = .none
//                cellAync.data = data
//                cellAync.delegate = self
//
//                print("addRunloopBlock execute")
//                cellAync.setNeedsDisplay()
//
//                return false
//
//            }
            
            
    
            
//             cellAync.displayAsync()
         
//            cellAync.clear()
//
//            backgroundQueue.async {
//
//                print("doSomething1 \(Thread.current)")
//
//                cellAync.displayAsync()
//
//
//            }
//
//            let operation = BlockOperation {() -> Void in
//
//                print("doSomething1 \(Thread.current)")
//
//
////            DispatchQueue.global().async {
//
//                cellAync.displayAsync()
//
////            }
//
//
//            }
            
//            cellAync.opeation = operation
            
//            queueDraw.addOperation(operation)
            
            
//            queueDraw.addOperation { () -> Void in
//
//
//                cellAync.displayAsync()
//
//            }
            
            
            return cellAync

            
        }else{
            
         let   cell = tableView.dequeueReusableCell(withIdentifier: "tableCellsync") as! TableCell
            cell.selectionStyle = .none
            cell.configForCell(data: data,index:indexPath.row)
            return cell

            
        }
        
        
        
    }
    
    
    func imageClick(index: Int) {
        
        print("imageClick index \(index)")
        
        let alert = UIAlertController(title: "点击了图片"+String(index), message: "haha", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: { _ in
            //Cancel Action
        }))
        
        alert.addAction(UIAlertAction(title: "取消",
                                      style: UIAlertActionStyle.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func linkClick() {
        
         print("linkClick")
        
        let alert = UIAlertController(title: "linkClick", message: "haha", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: { _ in
            //Cancel Action
        }))
        
        alert.addAction(UIAlertAction(title: "取消",
                                      style: UIAlertActionStyle.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
//        self.queueDraw.cancelAllOperations()

    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        //减速开始绘制
//        let table = scrollView as! UITableView
//
//        for cell in table.visibleCells   {
//
//            if isAsync {
//
//                let cellAync = cell as! AsyncTableCell
//
//                queueDraw.addOperation { () -> Void in
//
//
//                    cellAync.displayAsync()
//
//                }
//
//            }
        
            
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")

//        if !decelerate {//没有减速
//            
//            self.queueDraw.cancelAllOperations()
//        
//            return
//            
//        }
//        
       
            
            
//            print("cell\(cell)")
//            
//        }

        
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        


       
        
        
    }
    
    
    
}


extension TableController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("select index \(indexPath.row)")
        
//        let dataFormat = ["key1":"1行",
//                          "key2":"2行",
//                          "image":"https://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
//
//        var dataArray:[[String:Any]] = []
//
//        for _ in 0...10 {
//
//            dataArray.append(dataFormat)
//
//        }
//
//        let controller = TableController(data:dataArray)
//
//        self.navigationController?.pushViewController(controller, animated: true)
//
        
//        if (indexPath.row == 1){
//
//            let controller = SliderController()
//            self.navigationController?.pushViewController(controller, animated: true)
//
//            return
//
//        }
//
        
        if indexPath.row == 1 {
            
            dismiss(animated: true)

        }else{
            
            let controller = EmojiController()
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
        
        
    }
    
}

