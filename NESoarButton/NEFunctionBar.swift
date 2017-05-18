//
//  NEFunctionBar.swift
//  HeavenLife
//
//  Created by hosa on 2017/5/17.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

import UIKit

func kScreenWidth() -> CGFloat{
    return UIScreen.main.bounds.size.width
}

func kScreenHeight() -> CGFloat{
    return UIScreen.main.bounds.size.height
}

protocol NEFunctionBarDelegate {
    func functionBarDelegate(tag:Int)
}

class NEFunctionBar: UIView {
    
    var delegate:NEFunctionBarDelegate?
    
    
    var buttonNameS = ["T","O","K","Y","O","is","H","O","T"]
    var showViewH:CGFloat  = 50
    var soarButtonH:CGFloat     = 50
    var margin:CGFloat  = 10
    
    
    let baseTag:Int = 10010
    lazy var soarButton: NESoarButton = {

        let rect = CGRect(x: kScreenWidth() - self.soarButtonH, y: 0, width: self.soarButtonH, height: self.soarButtonH)
        let btn = NESoarButton(frame: rect)
        btn.backgroundColor = .blue
        btn.setImage(#imageLiteral(resourceName: "buttonImage"), for: .normal)
        btn.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var functionShowView: UIScrollView = {
        let showViewWidth = self.width - self.soarButtonH * (1 - 0.618)
        let showViewY     = self.soarButtonH * (1 - 0.618)
        let rect = CGRect(x: 0, y:showViewY , width: showViewWidth, height: self.showViewH )
        let sView = UIScrollView(frame: rect)
        sView.showsVerticalScrollIndicator = false
        sView.showsHorizontalScrollIndicator = false
        sView.backgroundColor = .green
        
        
        let buttonH:CGFloat = self.showViewH
        let buttonW:CGFloat = buttonH / 0.618
        for i in 0..<self.buttonNameS.count {
            let rect = CGRect(x: CGFloat(i) * (buttonW + self.margin) + self.margin, y: 0, width: buttonW, height: buttonH)
            let btn = UIButton(frame: rect)
            btn.setTitle(self.buttonNameS[i], for: .normal)
            btn.backgroundColor = .blue
            btn.tag = self.baseTag + i
            btn.addTarget(self, action: #selector(funcButtonDidClick(senter:)), for: .touchUpInside)
            sView.addSubview(btn)
        }
        sView.contentSize = CGSize(width: CGFloat(self.buttonNameS.count) * (buttonW + self.margin) + (self.soarButtonH * 0.618), height: 0)
        return sView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(functionShowView)
        addSubview(soarButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchUpInside(){
        print("touchUpInside")
        buttonRotate()
        barStretch()
    }
    
    func funcButtonDidClick(senter:UIButton){
        print("\(senter.tag - baseTag) -- \(senter.currentTitle!)")
        touchUpInside()
        self.delegate?.functionBarDelegate(tag: senter.tag - baseTag)
    }
}

//Animation
extension NEFunctionBar{
    
    func buttonRotate(){
        let angel:CGFloat           = CGFloat(Double.pi) * 2
        let animation = CASpringAnimation(keyPath: "transform.rotation.z")
        animation.mass              = 10.0
        animation.stiffness         = 1800
        animation.damping           = 200.0
        animation.initialVelocity   = 5
        animation.fromValue         = 0
        animation.toValue           = angel
        animation.duration          = 10
        soarButton.layer.add(animation, forKey: nil)
    }
    
    func barStretch() {

        let showViewWidth = self.width - self.soarButtonH * (1 - 0.618)
        
        var setp_1Rect:CGRect?
        var setp_2Rect:CGRect?
        var duration1:TimeInterval =  0.15
        var duration2:TimeInterval =  0.75

        if functionShowView.width < 100{
            setp_1Rect = CGRect(x: functionShowView.x, y: functionShowView.y, width: functionShowView.width, height:showViewH )
            setp_2Rect = CGRect(x: 0, y: functionShowView.y, width: showViewWidth, height: showViewH)
            duration1 =  0.15
            duration2 =  0.35

        }else{
            let showViewX = functionShowView.frame.maxX - (self.soarButtonH * (1 - 0.618))
            setp_1Rect = CGRect(x:showViewX, y: functionShowView.y, width: 20, height: functionShowView.height)
            setp_2Rect = CGRect(x:showViewX, y:functionShowView.y , width: 20, height: 20 )
            duration1 =  0.35
            duration2 =  0.15
        }
        
        UIView.animate(withDuration: duration1, animations: {
            self.functionShowView.frame = setp_1Rect!
        }) { (completion) in
            UIView.animate(withDuration: duration2, animations: {
                self.functionShowView.frame = setp_2Rect!
            })
        }
    }
}

class NESoarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addcornerRadius()
        addBorder(color: .white, borderWidth: 2)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
