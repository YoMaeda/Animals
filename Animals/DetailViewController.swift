//
//  DetailViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/09.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var wikiButton: UIButton!
    
    var info:[String]=[]
    let webView:UIWebView=UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title=info[0]
        label.text=info[1]
        
        wikiButton.layer.borderWidth=2.0
        wikiButton.layer.borderColor=UIColor.blue.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func wikiButtonTapped(_ sender: UIButton) {
        var url:URL
        let wikiURL="http://ja.wikipedia.org/wiki/"+info[0]
        let encodedURL=wikiURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
        url=URL(string:encodedURL)!
        
        let safariViewController=SFSafariViewController(url:url)
        present(safariViewController,animated:false,completion:nil)
    }
}
