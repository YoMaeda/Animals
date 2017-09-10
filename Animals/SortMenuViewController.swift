//
//  SortMenuViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/10.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit

class SortMenuViewController: UIViewController {
    
    @IBOutlet weak var sort1: UIButton!
    @IBOutlet weak var sort2: UIButton!
    let viewController=ViewController()
    
    //ボタンが押されると強調され、他のボタンが押されるまで押せなくなる
    func buttonPushed(button:UIButton){
        button.isEnabled=false
        button.setTitleColor(UIColor.black,for:.normal)
    }
    //他のボタンが押されると目立たなくなる
    func buttonNotPushed(button:UIButton){
        button.isEnabled=true
        button.setTitleColor(UIColor.gray,for:.normal)
    }
    
    //名前の昇順にソート
    @IBAction func sort1ButtonTapped(_ sender: UIButton) {
        viewController.sort1()
        buttonPushed(button:sort1)
        buttonNotPushed(button:sort2)
    }
    
    //名前の降順にソート
    @IBAction func sort2ButtonTapped(_ sender: UIButton) {
        viewController.sort2()
        buttonPushed(button:sort2)
        buttonNotPushed(button:sort1)
    }
}
