//
//  ViewController.swift
//  swiftDemo
//
//  Created by Fubao on 2018/7/20.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import UIKit

class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        
        fromView.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0
            
        },completion:{_ in
            
            containerView.addSubview(toView)
            
            toView.alpha = 0
            UIView.animate(withDuration: self.duration, animations: {
                toView.alpha = 1
                
            },completion:{_ in
                
                transitionContext.completeTransition(true)
                
            })
            
            //            transitionContext.completeTransition(true)
            
        })
        

        
    }
    
}

class FadeAnimatorDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!

//        containerView.addSubview(fromView)
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let mainScreenHeight = UIScreen.main.bounds.size.height
        
        toView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)

        fromView.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0

        },completion:{_ in
            
            containerView.addSubview(toView)

            toView.alpha = 0
            UIView.animate(withDuration: self.duration, animations: {
                toView.alpha = 1
                
            },completion:{_ in
                
                transitionContext.completeTransition(true)
                
            })
            
//            transitionContext.completeTransition(true)
            
        })
        
    }
    
}

class SwipeDismissAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let mainScreenHeight = UIScreen.main.bounds.size.height
        
        fromView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)
        containerView.addSubview(fromView)
        
        containerView.insertSubview(toView, belowSubview: fromView)

        UIView.animate(withDuration: duration, animations: {
            //            fromView.frame = CGRect.init(x: 0, y: -mainScreenHeight, width: mainScreenWidth, height: mainScreenHeight)
            fromView.frame = CGRect.init(x: 0, y:  mainScreenHeight, width: mainScreenWidth, height: mainScreenHeight)

            
        },completion:{_ in
            
            transitionContext.completeTransition(true)
            
        })
        
    }
    
}



class SwipeAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let mainScreenHeight = UIScreen.main.bounds.size.height

        containerView.addSubview(toView)
        toView.frame = CGRect.init(x: 0, y: mainScreenHeight, width: mainScreenWidth, height: mainScreenHeight)
        
        UIView.animate(withDuration: duration, animations: {
//            fromView.frame = CGRect.init(x: 0, y: -mainScreenHeight, width: mainScreenWidth, height: mainScreenHeight)
            toView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)

            
        },completion:{_ in
            
                transitionContext.completeTransition(true)
 
        })
        
    }
    
}

class PopAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let tabController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//        tabController.tabBar.isHidden = true
        
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        

        
        
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let mainScreenHeight = UIScreen.main.bounds.size.height
        
        containerView.insertSubview(toView, belowSubview: fromView)
        toView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)
        
        let superView = tabController.tabBar.superview
        
        let tabBar = tabController.tabBar
        tabBar.frame = CGRect.init(x: 0, y: mainScreenHeight - 49, width: mainScreenWidth, height: 49)
        toView.addSubview(tabBar)
        
        
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect.init(x: mainScreenWidth, y: 0, width: mainScreenWidth, height: mainScreenHeight)
//            toView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)
            
            
        },completion:{_ in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            tabBar.removeFromSuperview()
            
            superView?.addSubview(tabBar)
            
//            let index = tabController.selectedIndex
//
//            let nav = tabController.childViewControllers[index] as! BaseNavigationController
//
//            if nav.childViewControllers.count == 1 {
//
//
//                tabController.tabBar.isHidden = false
//
//
//                print("tabBar.superview \(tabBar.superview)")
//
////                 toView.frame = CGRect.init(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight - 49)
//
////                tabBar.removeFromSuperview();
//
//            }
            


        })
        
    }
    
}


import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    
    private let disposeBag = DisposeBag()
    var textField:UITextField = UITextField()
    
    let transition = SwipeAnimator()
    let transitionDismiss = FadeAnimatorDismiss()
    
    private var centerHeartLayer:CAEmitterLayer!
    private var pulsatorLayer:PulsatorLayer!
    
//    let popTransition = PopAnimator()
//    var interactivePopTransition = UIPercentDrivenInteractiveTransition()
    

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        pulsatorLayer.start()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      let viewModel = RegisterViewModel()
        
        addPresent()
        
        addPush()
        
        addWave()
        
        addEmit()
        
        addHeart()
        
        addPulse()

        
//        addTextField()
        
//        registerNotifications()
        
//        testMap()
        

    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
}




extension ViewController {
    
    
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(_:)),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(_:)),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
        
    }
    
    
    @objc func keyBoardWillShow(_ notification:Notification){
        
        let userInfo = notification.userInfo
        let KeyBoardHeight = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgSizeValue.height
        
        let textFieldBottom = textField.frame.origin.y + textField.frame.size.height
        let offSet = textFieldBottom+KeyBoardHeight - kScreenHeight
        let move = offSet > 0 ? offSet :0
        
        print("keyboardWillShow \(KeyBoardHeight) move \(move)")
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -move);
        
        
    }
    
    
    @objc func keyBoardWillHide(_ notification:Notification){
        
        
        print("keyboardWillHide")
        
        self.view.transform = CGAffineTransform.identity
        
        
    }
    
    
}



//MARK
extension ViewController {


    
    func addWave() {
        
        let wave = WaveView()
        wave.frame = CGRect.init(x: 0, y: 300, width: kScreenWidth, height: 80)
        wave.alwaysAnimation = true
        wave.waveColor = UIColor.red
        wave.amplitude = 10
        wave.speed = 5
        self.view.addSubview(wave)
        wave.startWave()

    }
    
    
    func addPulse()  {
        
//        let puls = UIView()
//        puls.frame = CGRect(x: 50, y: 450, width: 100, height: 100)
//        self.view.addSubview(puls)

        pulsatorLayer = PulsatorLayer()
        pulsatorLayer.frame = CGRect(x: view.bounds.width / 2, y: 500, width: 0, height: 0)
        self.view.layer.addSublayer(pulsatorLayer)
        
        pulsatorLayer.start()
        
    }
    
    
    func addEmit(){
        
        
        centerHeartLayer = CAEmitterLayer()
        centerHeartLayer.emitterShape = kCAEmitterLayerCircle
        centerHeartLayer.emitterMode = kCAEmitterLayerOutline
        centerHeartLayer.renderMode = kCAEmitterLayerOldestFirst
        centerHeartLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 450)
        centerHeartLayer.emitterSize = CGSize(width: 21, height: 21)
        centerHeartLayer.birthRate = 0
        
        let cell = CAEmitterCell()
        cell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        cell.lifetime = 1
        cell.birthRate = 2000
        cell.scale = 0.05
        cell.scaleSpeed = -0.02
        cell.alphaSpeed = -1
        cell.velocity = 30
        
        centerHeartLayer.emitterCells = [cell]
        view.layer.addSublayer(centerHeartLayer)
        
        
    }
    
    func addHeart(){
        
        let btn = UIButton.init(frame: CGRect.init(x:view.bounds.midX-21/2, y:450-21/2, width: 21, height: 21))
        let image = UIImage.init(imageLiteralResourceName: "Heart_red")
        btn.setImage(image, for: .normal)
        btn.addTarget(self,action: #selector(heatAnimation), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
    }

    
    
    
}


extension ViewController {
    

    func addTextField() -> Void {
        
        textField.frame = CGRect.init(x: 100, y: 300, width: 100, height: 80)
        textField.placeholder = "请输入文字"
        view.addSubview(textField)
        
        
        textField.rx.text.orEmpty.subscribe {
            print($0)
            
            }.disposed(by: disposeBag)
        
    }
    
    
    func addPresent() -> Void {
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("present", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(presentAction), for: .touchUpInside)
        btn.ts_touchInsets = .init(top: -30, left: -30, bottom: -30, right: -30)

        self.view.addSubview(btn)
        
    }
    
    func addPush() -> Void {
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 100, height: 40))
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("push", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self,action: #selector(pushAction), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func testMap() {
        
        //类方法
        Map.constructStack()
        Map.stringLength(["T##Map","protcol##"])
        
        //实例方法
        let map = Map()
        map.eat()
        map.run()
        
        //闭包
        let work = Worker(job:"developer")
        work.callClourse()
        
        //
        work.codeJson()
        work.decodeJson()
        
    }
    
    @objc func heatAnimation() -> Void {
        
        centerHeartLayer.beginTime = CACurrentMediaTime() // There will be too many cell without setting begin time
        centerHeartLayer.birthRate = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.centerHeartLayer.birthRate = 0
        }
        
    }
    
    @objc func presentAction() {
        
//        let controller = ChildController(name:"name",parameter:["name":"child"])
        let dataFormat = ["key1":"1行",
                           "key2":"2行",
                           "image":"https://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]
        
        var dataArray:[[String:Any]] = []
        
        for _ in 0...10 {
            
            dataArray.append(dataFormat)
            
        }
        
        let controller = TableController(data: dataArray, isAsync: false)
        
        let fade = FadeAnimator()
        let dismiss = FadeAnimatorDismiss()
        
        self.transitionPresent = fade
        self.transitionPresentDismiss = dismiss
        
//        controller.transitioningDelegate = self

        present(controller, animated: true, completion: nil)
        
        
    }
    
    @objc func pushAction() {
        
//      let controller = ChildController(parameter:["name":"child"])
//
//        let pop = PopAnimator()
//
//        controller.popTransition = pop
        
        let dataFormat = ["key1":"1行",
                           "key2":"2行",
                           "image":"https://mvimg2.meitudata.com/55fe3d94efbc12843.jpg"]

        var dataArray:[[String:Any]] = []

        for _ in 0...10 {

            dataArray.append(dataFormat)

        }

        let controller = TableController(data: dataArray, isAsync: true)

        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    
}



