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
    var length:String=""
    var weight:String=""
    let webView:UIWebView=UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //動物の名前
        navigationItem.title=info[0]
        
        //動物の説明文
        //体長
        if Double(info[1])!>=100{ //1m以上→m単位
            length=String(Double(info[1])!/100)+"m"
        }
        else{ //1m未満→cm単位
            length=String(Double(info[1])!)+"cm"
        }
        //体重
        if Double(info[2])!>=1000{ //1t以上→t単位
            weight=String(Double(info[2])!/1000)+"t"
        }
        else if Double(info[2])!<1{ //ikg未満→g単位
            weight=String(Double(info[2])!*1000)+"g"
        }
        else{ //1~1000kg→kg単位
            weight=String(Double(info[2])!)+"kg"
        }
        label.text="体長 : "+length+"\n"+"体重 : "+weight+"\n\n\n"+info[3]
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
