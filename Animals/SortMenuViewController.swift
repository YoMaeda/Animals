//
//  SortMenuViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/10.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit

class SortMenuViewController: UIViewController {
    
    //var item:[[String]]
    
    let viewController=ViewController()
    
    @IBAction func sort1ButtonTapped(_ sender: UIButton) {
        //let viewController = ViewController()
        viewController.sort1()
        //viewController.tableView.reloadData()
        //print("aaa")
    }
    
    @IBAction func sort2ButtonTapped(_ sender: UIButton) {
        viewController.sort2()
    }
}
