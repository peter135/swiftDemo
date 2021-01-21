//
//  EmojiKeyboardView.swift
//  swiftDemo
//
//  Created by peter on 2019/1/11.
//  Copyright © 2019 Fubao. All rights reserved.
//

import Foundation
import UIKit

protocol EmojiKeyBoardViewDelegate:NSObjectProtocol{
    
    func keyBoradOutputAttribute(_ attribute:NSAttributedString)
    func recordInit(_ name:String)
    func recordFileSuccess(path:String,time:Int,name:String)
    func recordCancel(_ name:String)
    func recordFileFail(name:String)
    
}

class EmojiKeyboardView: UIView {
    
    var defineHeight:CGFloat{
        
        return heightWithFit() + safeAreaBottom()
    }
    
    private(set) var isShowKeyBoard:Bool = false
    weak var delegate:EmojiKeyBoardViewDelegate?
    private let line = UIView()
    
    var initFrame:CGRect = .zero
    
    init(){
        
        super.init(frame: .zero)
//        addInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFrame = frame
//        addInit()
    }
    
    
//
//    addInit(){
//
//
//    }
    
    
    /// 通过最大行和最小行计算textView 高度
    private func heightWithFit() -> CGFloat {
        let textViewHeight = textView.layoutManager.usedRect(for: textView.textContainer).size.height + MYTextViewTextDefineHeight
        
        let minHeight = heightWithLine(MYEmojiTextMinLine)
        let maxHeight = heightWithLine(MYEmojiTextMaxLine)
        let calculateHeight = min(maxHeight, max(minHeight, textViewHeight))
        
        return calculateHeight + MYTextViewTopBottomSpace * 2
    }
    
    /// 计算行高
    private func heightWithLine(_ lineNumber : Int) -> CGFloat{
        let onelineStr = NSString()
        let onelineRect = onelineStr.boundingRect(with: CGSize(width: textView.my.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.systemFont(ofSize: MYTextViewTextFont)], context: nil)
        return onelineRect.size.height * CGFloat(lineNumber) + MYTextViewTextDefineHeight
    }
    
    //MARK: - 懒加载
//    
//    private lazy var textView: MYTextView = {
//        let view = MYTextView.init(frame: .zero, textContainer: nil)
//        view.font = UIFont.systemFont(ofSize: MYTextViewTextFont)
//        view.scrollsToTop = false
//        view.returnKeyType = .send
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 5.0
//        view.enablesReturnKeyAutomatically = true
//        view.inputAccessoryView = UIView()
//        if #available(iOS 11.0, *) {
//            view.textDragInteraction?.isEnabled = false
//        }
//        view.delegate = self
//        return view
//    }()
//    
//    private lazy var voiceView : MYVoiceTouchView = {
//        let view = MYVoiceTouchView()
//        view.delegate = self.recordHandle
//        return view
//    }()
//    
//    private lazy var voiceButton: UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage(named: "toggle_record"), for: .selected)
//        button.setImage(UIImage(named:"toggle_keyboard"), for: .normal)
//        button.addTarget(self, action: #selector(voiceButtonDown(_:)), for: .touchUpInside)
//        button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
//        return button
//    }()
//    
//    private lazy var funcButton: UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage(named: "toggle_func"), for: .normal)
//        button.setImage(UIImage(named: "toggle_func"), for: .selected)
//        button.addTarget(self, action: #selector(moreFuncButtonDown(_:)), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var emojiButton: UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage(named: "toggle_emoji"), for: .normal)
//        button.setImage(UIImage(named: "toggle_keyboard"), for: .selected)
//        button.addTarget(self, action: #selector(emojiButtonDown(_:)), for: .touchUpInside)
//        button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
//        return button
//    }()
//    
//    private lazy var emojiView : MYEmojiKeyboardView = {
//        
//        let view = MYEmojiKeyboardView.init(frame: .init(x: 0, y: emojiViewMaxHeight, width: my.width, height: emojiViewMaxHeight))
//        view.isHidden = true
//        view.delegate = self
//        return view
//    }()
//    
//    private lazy var functionsView : UIView = {
//        
//        let view = UIView.init(frame: .init(x: 0, y: emojiViewMaxHeight, width: my.width, height: emojiViewMaxHeight))
//        let tipLabel = UILabel()
//        tipLabel.frame = .init(x: 20, y: 20, width: 100, height: 20)
//        tipLabel.textAlignment = .center
//        tipLabel.text = "无页面布局"
//        
//        view.addSubview(tipLabel)
//        view.isHidden = true
//        
//        return view
//    }()
//    
//    private lazy var recordHandle : MYRecordHandled = {
//        let handle = MYRecordHandled()
//        handle.delegate = self
//        return handle
//    }()
    
    
    deinit {
        /// 移除所有的通知
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
