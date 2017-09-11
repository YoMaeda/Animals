//
//  SortMenuViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/10.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit
import ChameleonFramework

class SortMenuViewController: UIViewController {
    
    @IBOutlet weak var sort1: UIButton!
    @IBOutlet weak var sort2: UIButton!
    @IBOutlet weak var sort3: UIButton!
    @IBOutlet weak var sort4: UIButton!
    @IBOutlet weak var sort5: UIButton!
    @IBOutlet weak var sort6: UIButton!
    let viewController=ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=GradientColor(UIGradientStyle.leftToRight,frame:view.frame,colors:[.flatWhite,.flatGreen,.green,.flatGreenDark,.flatForestGreen])
        
        //デフォルトは名前の五十音順
        viewController.sort1()
        buttonPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort5)
        buttonNotPushed(button:sort6)
    }
    
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
    @IBAction func sort1ButtonTapped(_ sender: UIButton){
        viewController.sort1()
        buttonPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort5)
        buttonNotPushed(button:sort6)
    }
    
    //名前の降順にソート
    @IBAction func sort2ButtonTapped(_ sender: UIButton){
        viewController.sort2()
        buttonPushed(button:sort2)
        buttonNotPushed(button:sort1)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort5)
        buttonNotPushed(button:sort6)
    }
    
    //体長の長い順にソート
    @IBAction func sort3ButtonTapped(_ sender: UIButton){
        viewController.sort3()
        buttonPushed(button:sort3)
        buttonNotPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort5)
        buttonNotPushed(button:sort6)
    }
    
    //体長の短い順にソート
    @IBAction func sort4ButtonTapped(_ sender: UIButton){
        viewController.sort4()
        buttonPushed(button:sort4)
        buttonNotPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort5)
        buttonNotPushed(button:sort6)
    }
    
    //体重の重い順にソート
    @IBAction func sort5ButtonTapped(_ sender: UIButton){
        viewController.sort5()
        buttonPushed(button:sort5)
        buttonNotPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort6)
    }
    
    //体重の軽い順にソート
    @IBAction func sort6ButtonTapped(_ sender: UIButton){
        viewController.sort6()
        buttonPushed(button:sort6)
        buttonNotPushed(button:sort1)
        buttonNotPushed(button:sort2)
        buttonNotPushed(button:sort3)
        buttonNotPushed(button:sort4)
        buttonNotPushed(button:sort5)
    }
}
