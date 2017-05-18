//
//  ViewController.swift
//  NESoarButton
//
//  Created by hosa on 2017/5/17.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 500, width: kScreenWidth(), height: 80)
        let soarButton = NEFunctionBar(frame: rect)
        soarButton.backgroundColor = .red
        view.addSubview(soarButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

