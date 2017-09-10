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
        
        //動物の説明文
        navigationItem.title=info[0]
        label.text=info[1]
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Wikipediaの該当ページへのリンク
    @IBAction func wikiButtonTapped(_ sender: UIButton) {
        var url:URL
        let wikiURL="http://ja.wikipedia.org/wiki/"+info[0] //動物名のURL
        let encodedURL=wikiURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)! //wikiURLをエンコードしないとうまくリンクできない
        url=URL(string:encodedURL)!
        
        //アプリ内でSafariを起動
        let safariViewController=SFSafariViewController(url:url)
        present(safariViewController,animated:false,completion:nil)
    }
}
