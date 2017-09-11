//
//  ViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/09.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    private var sortMenuViewController:UIViewController!
    var appear=0 //サイドメニューが現れたかどうかを確認する変数
    
    var items:[[String]]=[]
    var appDelegate=UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().backgroundColor=UIColor.flatSkyBlue
        navigationItem.title="Animals"
        
        //csvファイル"AnimalInfo.csv"から動物のデータを2次元配列に読み込む
        if let csvPath=Bundle.main.path(forResource:"AnimalInfo",ofType:"csv"){
            do{
                let csvStr=try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                let csvArr=csvStr.characters.split(separator:"\n").map(String.init)
                for csvFile in csvArr {
                    let csvSpl=csvFile.components(separatedBy:",")
                    items.append(csvSpl)
                }
            }
            catch{
            }
        }
        /*
         AnimalInfo.csvでは以下のようにデータを書く
         名前,体長(cm単位),体重(kg単位),説明
         ※体長と体重はString型で記録されるため、ソートするときは以下のようにDouble型にキャストする
            appDelegate.searchResult?.sort(by:{Double($0[1])!>Double($1[1])!})
         */
        
        //tableView関連の設定
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=UIColor(gradientStyle:.leftToRight,withFrame:tableView.frame,andColors:[.flatGreen,.green,.flatForestGreen])
        
        //searchBar関連の設定
        searchBar.delegate=self
        searchBar.enablesReturnKeyAutomatically=false
        
        //最初の検索結果をitems全体にする
        appDelegate.searchResult=items
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //データの個数を返す
    func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
        return (appDelegate.searchResult?.count)!
    }
    
    //データを返す
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        let cell:UITableViewCell!=tableView.dequeueReusableCell(withIdentifier:"NameCell")
        cell.textLabel?.text=appDelegate.searchResult?[indexPath.row][0]
        
        //未選択のセルを透明にする
        cell.backgroundColor=UIColor.clear
        //選択されたセルに色を付ける
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor(gradientStyle:.leftToRight,withFrame:view.frame,andColors:[.flatGreen,.flatForestGreen])
        cell.selectedBackgroundView=cellSelectedBgView
        
        return cell
    }
    
    //値の受け渡しを行う
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        if let selectedRow=tableView.indexPathForSelectedRow{
            let controller=segue.destination as! DetailViewController
            controller.info=(appDelegate.searchResult?[selectedRow.row])!
        }
    }
    
    //検索ボタンを押した時の挙動
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true) //キーボードを閉じる
    }
    
    //キャンセルボタンが押された時の挙動
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text=""
        searchBar.showsCancelButton=false
        searchBar.resignFirstResponder()
        appDelegate.searchResult=items
        
        //ソートした結果がリセットされるのを防ぐ
        switch appDelegate.sortFlag{
            case 1:
                sort1()
            case 2:
                sort2()
            case 3:
                sort3()
            case 4:
                sort4()
            case 5:
                sort5()
            case 6:
                sort6()
            default:
                appDelegate.sortFlag=0
        }
        tableView.reloadData()
    }
    
    //テキストを変更した時の挙動
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        appDelegate.searchResult?.removeAll()
        
        if searchBar.text==""{
            appDelegate.searchResult=items //検索文字が未入力の時はすべてを表示
        }
        else{
            for data in items{
                if data[0].contains(searchBar.text!){
                    appDelegate.searchResult?.append(data)
                }
            }
        }

        tableView.reloadData() //表示データを再度読み込む
    }
   
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton=true
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    self.sortMenuViewController=self.storyboard?.instantiateViewController(withIdentifier:"sortMenu")
        
        self.addChildViewController(self.sortMenuViewController)
        self.view.addSubview(self.sortMenuViewController.view)
        self.sortMenuViewController.didMove(toParentViewController:self)
        
        self.sortMenuViewController.view.isHidden=true
        self.view.bringSubview(toFront:self.sortMenuViewController.view)
    }
    
    //サイドメニューを開く処理
    func presentMenuViewController(){
        searchBar.endEditing(true)
        sortMenuViewController.beginAppearanceTransition(true, animated:true)
        self.sortMenuViewController.view.isHidden=false
        self.sortMenuViewController.view.frame=sortMenuViewController.view.frame.offsetBy(dx:-sortMenuViewController.view.frame.size.width,dy:0)
        UIView.animate(withDuration:0.3,delay:0,usingSpringWithDamping:0.8, initialSpringVelocity:0.3,options:UIViewAnimationOptions.curveEaseOut,animations:{
            let bounds=self.sortMenuViewController.view.bounds
            self.sortMenuViewController.view.frame=CGRect(x:-bounds.size.width/2, y:0,width:bounds.size.width,height:bounds.size.height)
        },completion:{_ in
            self.sortMenuViewController.endAppearanceTransition()
        })
        tableView.allowsSelection=false //サイドメニューを開いている間にセルを押しても反応させない
        appear=1
    }
    
    
    //サイドメニューを閉じる処理
    func dismissMenuViewController(){
        self.sortMenuViewController.beginAppearanceTransition(false, animated: true)
        UIView.animate(withDuration:0.3,delay:0,options:.curveEaseOut, animations:{
            self.sortMenuViewController.view.frame=self.sortMenuViewController.view.frame.offsetBy(dx:-self.sortMenuViewController.view.bounds.size.width/2,dy:0)
        },completion:{_ in
            self.sortMenuViewController.view.isHidden=true
            self.sortMenuViewController.endAppearanceTransition()
        })
        tableView.allowsSelection=true //サイドメニューを閉じたらセルが反応するようにする
        appear=0
    }
    
    //サイドメニュー用の設定
    func set(ViewController:UIViewController){
        if let currentContentViewController = self.sortMenuViewController{
            guard type(of:currentContentViewController) != type(of:sortMenuViewController) else { return }
        }
        
        // 既存コンテンツの開放
        self.sortMenuViewController.willMove(toParentViewController: nil)
        self.sortMenuViewController.view.removeFromSuperview()
        self.sortMenuViewController.removeFromParentViewController()
        
        // 新コンテンツのセット
        self.view.addSubview(sortMenuViewController.view)
        self.view.bringSubview(toFront:self.sortMenuViewController.view)
        self.addChildViewController(sortMenuViewController)
        
        // 新コンテンツフェードイン
        sortMenuViewController.view.alpha=0
        UIView.animate(withDuration:0.3,animations: {
            self.sortMenuViewController.view.alpha=1
        }, completion: { _ in
            self.sortMenuViewController.didMove(toParentViewController:self)
        })
    }
    
    //サイドメニューボタンが押された時の処理
    @IBAction func sortButtonTapped(_ sender:UIBarButtonItem){
        if appear==0{
            self.presentMenuViewController()
            sortButton.title="Done"
        }
        else{
            self.dismissMenuViewController()
            sortButton.title="Sort"
        }
        tableView.reloadData()
    }
    
    //データのソート用の関数
    func sort1(){ //名前の昇順
        appDelegate.searchResult?.sort(by:{$0[0]<$1[0]})
        appDelegate.sortFlag=1
    }
    func sort2(){ //名前の降順
        appDelegate.searchResult?.sort(by:{$0[0]>$1[0]})
        appDelegate.sortFlag=2
    }
    func sort3(){ //体長の長い順
        appDelegate.searchResult?.sort(by:{Double($0[1])!>Double($1[1])!})
        appDelegate.sortFlag=3
    }
    func sort4(){ //体長の短い順
        appDelegate.searchResult?.sort(by:{Double($0[1])!<Double($1[1])!})
        appDelegate.sortFlag=4
    }
    func sort5(){ //体重の重い順
        appDelegate.searchResult?.sort(by:{Double($0[2])!>Double($1[2])!})
        appDelegate.sortFlag=5
    }
    func sort6(){ //体長の短い順
        appDelegate.searchResult?.sort(by:{Double($0[2])!<Double($1[2])!})
        appDelegate.sortFlag=6
    }
}

extension UIViewController {
    func sortMenuViewController() -> SortMenuViewController? {
        var vc=self.parent
        while(vc != nil){
            guard let viewController=vc else { return nil }
            if viewController is SortMenuViewController {
                return viewController as? SortMenuViewController
            }
            vc=viewController.parent
        }
        return nil
    }
}
