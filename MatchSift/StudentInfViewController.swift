//
//  StudentInfViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/04/10.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class StudentInfViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
     @IBOutlet var studentTableView: UITableView!
    
   //画面が立ち上がった時にこの値は空になっているから,!や?は必要なのか？
    var studentInfArray = [NCMBObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //このコードはviewDidLoadの中でいいのか？この画面になるたびに読まれる必要はないのか？
        studentTableView.dataSource = self
        studentTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInf()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //こういう関数はこの画面になるたびに読み込まれるのか？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInfArray.count
    }
  
    //セルには名前を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentInfCell")!
    //for keyにはクラス名が入るのか、fieldが入るのかわからない。名前の列だけを拾いたい。asの後はなぜ？なのか
        cell.textLabel?.text = studentInfArray[indexPath.row].object(forKey: "name") as? String
        return cell
    }
    
    func loadInf() {
        let query  = NCMBQuery(className: "studentInf")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error")
            }else{
                self.studentInfArray = result as! [NCMBObject]
            //これは具体的になんのために書いているのか？無いとどうなるのか？
                self.studentTableView.reloadData()
            }
        })
    }
    
    //User Defaultsの代わりにNiftyCloudがある。prepare for segueを使ったら値渡しできる。
    //セルをタップすると詳細画面に遷移する必要がある。ここにアラートを書いた方がよく無いか？
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //編集か削除か選んでもらう
        let funcAlert = UIAlertController(title: "編集or削除", message: "選択してください。", preferredStyle: .alert)
        
        
        let deleteAction = UIAlertAction(title: "削除", style: .default) { (action) in
            //削除を押すとまず確認アラートを表示する。okなら押されたセルを認知して、削除する。キャンセルなら閉じる。
            funcAlert.dismiss(animated: true, completion: nil)
            let cautionAlert = UIAlertController(title: "確認", message: "削除します。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK!", style: .default) { (action) in
                let selectedIndex = self.studentTableView.indexPathForSelectedRow!
                self.studentInfArray[selectedIndex.row].deleteInBackground({ (error) in
                    if error != nil{
                        print("error")
                    }else{
                        cautionAlert.dismiss(animated: true, completion: nil)
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.loadInf()
                    }
                })
            }
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ (action) in
                cautionAlert.dismiss(animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
            cautionAlert.addAction(okAction)
            cautionAlert.addAction(cancelAction)
            self.present(cautionAlert, animated: true, completion: nil)
        }
        
        let editAction = UIAlertAction(title: "編集", style: .default) { (action) in
            //編集を押すと遷移する。アラートが消える。
            self.performSegue(withIdentifier: "toStudentDetail", sender: nil)
            funcAlert.dismiss(animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        funcAlert.addAction(editAction)
        funcAlert.addAction(deleteAction)
        present(funcAlert, animated: true, completion: nil)
        
    }
    
    //値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStudentDetail" {
            let studentDetailViewController = segue.destination as! StudentDetailViewController
        //どこがタップされたのかを取得する。
            let selectedIndex = studentTableView.indexPathForSelectedRow!
        //なぜ studentInfarray[indexpath.row] じゃダメなのか？
            studentDetailViewController.passedStudentInf = studentInfArray[selectedIndex.row]
            
        }
        
    }
    //セルをタップした時にアラートで編集か削除か選ばせるのはどうだろうか？
    //親切なアプリってなんだろう？
    //ユーザーは何を使いやすいと考える？
 
}
