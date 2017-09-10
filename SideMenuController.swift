//
//  SideMenuController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/10.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    var data:[[String]]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sortButtonTapped(_ sender: UIButton) {
        switch sender.currentTitle!{
            case "ア→ン":
                data.sort(by:{$0[0]<$1[0]})
            case "ン→ア":
                data.sort(by:{$0[0]>$1[0]})
            default:
                data.sort(by:{$0[0]<$1[0]})
        }
    }
}
