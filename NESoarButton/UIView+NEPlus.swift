//
//  UIView+NEPlus.swift
//  HeavenLife
//
//  Created by hosa on 2017/4/18.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

import UIKit

extension UIView{

    //加圆角
    func addcornerRadius(radius:CGFloat? = nil){
        layer.cornerRadius = radius ?? width * 0.5
        layer.masksToBounds = true
    }
    //加边框
    func addBorder(color:UIColor,borderWidth:CGFloat? = nil){
        layer.borderWidth = borderWidth ?? 1
        layer.borderColor = color.cgColor
    }
}






