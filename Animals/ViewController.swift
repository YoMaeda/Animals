//
//  ViewController.swift
//  Animals
//
//  Created by 前田庸 on 2017/09/09.
//  Copyright © 2017年 Yo Maeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var sortMenuViewController:UIViewController!
    
    var items:[[String]]=[]
    var searchResult:[[String]]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //items.sort(by:{$0[0]<$1[0]}) //csvファイルから読み込んだ動物のデータを名前の五十音順に並べ替える
        items.reverse()
        
        tableView.dataSource=self
        
        searchBar.delegate=self
        searchBar.enablesReturnKeyAutomatically=false
        searchResult=items
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //データの個数を返す
    func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
        return searchResult.count
    }
    
    //データを返す
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        let cell:UITableViewCell!=tableView.dequeueReusableCell(withIdentifier:"NameCell")
        cell.textLabel?.text=searchResult[indexPath.row][0]
        return cell
    }
    
    //値の受け渡しを行う
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        if let selectedRow=tableView.indexPathForSelectedRow{
            let controller=segue.destination as! DetailViewController
            controller.info=searchResult[selectedRow.row]
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
        searchResult=items
        tableView.reloadData()
    }
    
    //テキストを変更した時の挙動
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult.removeAll()
        
        if searchBar.text==""{
            searchResult=items //検索文字が未入力の時はすべてを表示
        }
        else{
            for data in items{
                if data[0].contains(searchBar.text!){
                 searchResult.append(data)
                }
            }
        }
        
        tableView.reloadData() //表示データを再度読み込む
    }
   
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton=true
        return true
    }
    
    //
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.sortMenuViewController=self.storyboard?.instantiateViewController(withIdentifier:"sortMenu")
        self.addChildViewController(self.sortMenuViewController)
        self.view.addSubview(self.sortMenuViewController.view)
        self.sortMenuViewController.didMove(toParentViewController:self)
        
        self.sortMenuViewController.view.isHidden=true
        self.view.bringSubview(toFront:self.sortMenuViewController.view)
    }
    
    func presentMenuViewController(){
        sortMenuViewController.beginAppearanceTransition(true, animated:true)
        self.sortMenuViewController.view.isHidden=false
        self.sortMenuViewController.view.frame=sortMenuViewController.view.frame.offsetBy(dx:-sortMenuViewController.view.frame.size.width,dy:0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            let bounds = self.sortMenuViewController.view.bounds
            self.sortMenuViewController.view.frame = CGRect(x:-bounds.size.width / 2, y:0, width:bounds.size.width, height:bounds.size.height)
        }, completion: {_ in
            self.sortMenuViewController.endAppearanceTransition()
        })
    }
    
    func dismissMenuViewController(){
        self.sortMenuViewController.beginAppearanceTransition(false, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.sortMenuViewController.view.frame = self.sortMenuViewController.view.frame.offsetBy(dx: -self.sortMenuViewController.view.bounds.size.width / 2, dy: 0)
        }, completion: {_ in
            self.sortMenuViewController.view.isHidden = true
            self.sortMenuViewController.endAppearanceTransition()
        })
    }
}

extension UIViewController {
    func sortMenuViewController() -> SortMenuViewController? {
        var vc = self.parent
        while(vc != nil){
            guard let viewController = vc else { return nil }
            if viewController is SortMenuViewController {
                return viewController as? SortMenuViewController
            }
            vc = viewController.parent
        }
        return nil
    }
 */
}

