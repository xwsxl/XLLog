//
//  LogView.swift
//  XLTongHuaCaculateSwift
//
//  Created by Liang Xiang on 04/10/2022.
//

import UIKit
import SnapKit
public protocol AssisitiveTouchBtnProtocol {
    func tap(gesture:UITapGestureRecognizer)
}

public class DebugLogger: NSObject, logProtocol, AssisitiveTouchBtnProtocol {
    public static let shared = DebugLogger()
    var logString: String = ""
    var keyView:UIView?
    var assiitiveTouch: AssisitiveTouchBtn = AssisitiveTouchBtn(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    override init() {
        super.init()
        assiitiveTouch.delegate = self
        updateLogViewMessage()
    }
    
    public func setKeyView(_ view:UIView) {
        assiitiveTouch.removeFromSuperview()
        keyView = view
        view.addSubview(assiitiveTouch)
    }
    
    public func log(_ message: String) {
        logString.append(message)
        logString.append("\n")
        updateLogViewMessage()
        
    }
    
    public func tap(gesture: UITapGestureRecognizer) {
        showLogView()
    }
    
    
    func updateLogViewMessage() {
        LogView.shared.textView.text = logString
    }
    
    func showLogView() {
        guard let keyView = keyView else { return }
        LogView.shared.showLogView(keyView)
    }
    func hideLogView() {
        LogView.shared.hideLogView()
    }
}


class AssisitiveTouchBtn: UIView {
    var delegate:AssisitiveTouchBtnProtocol?
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.layer.cornerRadius = frame.size.height / 2.0;
        self.clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        addGestureRecognizer(pan)
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func pan(gesture:UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }

        switch gesture.state {
        case .began:
            startPoint = gesture.location(in: view)
        case .changed:
            let newPoint = gesture.location(in: view)
            let deltaX = newPoint.x - startPoint.x
            let deltaY = newPoint.y - startPoint.y
            view.center = CGPoint(x: view.center.x + deltaX, y: view.center.y + deltaY)
        case .ended:
            break
        case .cancelled:
                break
        case .failed:
                break
        default:
            break
        }
        
    }
    
    @objc func tap(gesture:UITapGestureRecognizer) {
        delegate?.tap(gesture: gesture)
    }
    
    
}

public class LogView: UIView {
    static let shared = LogView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var textView: UITextView = UITextView.init()
    var closeBtn: UIButton = UIButton(type:.custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setUpViews()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func closeBtnClick(sender: UIButton) {
        hideLogView()
    }
    
    func setUpViews() {
        closeBtn.setTitleColor(UIColor.blue, for: .normal)
        closeBtn.setTitle("Cancel", for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick(sender:)), for: .touchUpInside)
        addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(40)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.safeAreaInsets.top + 20)
            } else {
                // Fallback on earlier versions
            }
        }
        
        textView.textContainer.maximumNumberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        textView.isEditable = false
        textView.textContainer.lineBreakMode = .byCharWrapping
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(closeBtn.snp.bottom).offset(10)
            make.bottom.equalTo(self)
        }
    }
    func showLogView(_ superView: UIView) {
        superView.addSubview(self)
    }
    func hideLogView() {
        self.removeFromSuperview()
    }
}
