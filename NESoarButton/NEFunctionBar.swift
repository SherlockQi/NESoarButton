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
    

    
    let duration:CFTimeInterval    = 5
    let buttonNameS = ["T","O","K","Y","O","is","H","O","T"]
    let baseTag:Int = 10010
    
    lazy var soarButton: NESoarButton = {
        let buttonWidth:CGFloat = self.height * 0.618
        let buttonHeight        = buttonWidth
        
        let rect = CGRect(x: kScreenWidth() - buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
        let btn = NESoarButton(frame: rect)
        btn.backgroundColor = .blue
        btn.setImage(#imageLiteral(resourceName: "buttonImage"), for: .normal)
        btn.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var functionShowView: UIScrollView = {
        
        let showViewWidth:CGFloat   = 20
        let showViewHeight:CGFloat  = 20
        let showViewX               = self.width - (self.height * 0.618 * (1 - 0.618)) - showViewWidth
        let showViewY               = self.height * 0.618 * (1 - 0.618)
        let rect = CGRect(x: showViewX, y:showViewY , width: showViewWidth, height: showViewHeight )
        let sView = UIScrollView(frame: rect)
        sView.showsVerticalScrollIndicator = false
        sView.showsHorizontalScrollIndicator = false
        sView.backgroundColor = .green
        
        
        let buttonH:CGFloat = self.height * 0.618
        let buttonW:CGFloat = buttonH / 0.618
        let margin:CGFloat  = 10
        for i in 0..<self.buttonNameS.count {
            let rect = CGRect(x: CGFloat(i) * (buttonW + margin) + margin, y: 0, width: buttonW, height: buttonH)
            let btn = UIButton(frame: rect)
            btn.setTitle(self.buttonNameS[i], for: .normal)
            btn.backgroundColor = .blue
            btn.tag = self.baseTag + i
            btn.addTarget(self, action: #selector(funcButtonDidClick(senter:)), for: .touchUpInside)
            sView.addSubview(btn)
        }
        sView.contentSize = CGSize(width: CGFloat(self.buttonNameS.count) * (buttonW + margin) + 50, height: 0)
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
    }
}

//Animation
extension NEFunctionBar{
    
    func buttonRotate(){
        let angel:CGFloat       = CGFloat(Double.pi) * 2
        let animation = CASpringAnimation(keyPath: "transform.rotation.z")
        animation.mass = 10.0;
        animation.stiffness = 1800;
        animation.damping = 200.0;
        animation.initialVelocity = 5;
        animation.fromValue     = 0
        animation.toValue       = angel
        animation.duration      = duration
        soarButton.layer.add(animation, forKey: nil)
    }
    
    func barStretch() {
        let showViewWidth:CGFloat   = self.width - (self.height * 0.618 * (1 - 0.618))
        let showViewHeight          = self.height * 0.618
        
        var setp_1Rect:CGRect?
        var setp_2Rect:CGRect?
        
        if functionShowView.width < 100{
            setp_1Rect = CGRect(x: functionShowView.x, y: functionShowView.y, width: functionShowView.width, height: self.height * 0.618)
            setp_2Rect = CGRect(x: 0, y: functionShowView.y, width: showViewWidth, height: showViewHeight)
        }else{
            let showViewX = functionShowView.frame.maxX - 20
            setp_1Rect = CGRect(x:showViewX, y: functionShowView.y, width: 20, height: functionShowView.height)
            setp_2Rect = CGRect(x:showViewX, y:functionShowView.y , width: 20, height: 20 )
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.functionShowView.frame = setp_1Rect!
        }) { (completion) in
            UIView.animate(withDuration: 0.5, animations: {
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
