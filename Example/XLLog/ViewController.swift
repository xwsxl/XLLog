//
//  ViewController.swift
//  XLLog
//
//  Created by xiangliang on 10/13/2022.
//  Copyright (c) 2022 xiangliang. All rights reserved.
//

import UIKit
import XLLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Log.startWith([DebugLogger.shared, ConsoleLogger.shared])
        DebugLogger.shared.setKeyView(UIApplication.shared.keyWindow ?? self.view)
        for i in 1...9 {
            for j in i...9 {
                Log.verbose(.VC, "\(i) * \(j) = \(i * j)")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

