//
//  TeacherInfViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/01.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class TeacherInfViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var teacherTableView: UITableView!
    var teacherInfArray = [NCMBObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teacherTableView.dataSource = self
        teacherTableView.delegate = self
        // Do any additional setup after loading the view.＿
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherInfArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherInfCell")!
        cell.textLabel?.text = teacherInfArray[indexPath.row].object(forKey: "name") as? String
        return cell
    }
    
    func load(){
        let query = NCMBQuery(className: "teacherInf")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print("error1")
            }else{
                print("success")
                self.teacherInfArray = result as! [NCMBObject]
                self.teacherTableView.reloadData()
            }
        })
    }
    
//セルをタップすると詳細画面を表示する、値渡しする、何番目のセルがタップされているかを取得する。
//値を渡す必要があるのか？次の画面が立ち上がる時にNiftyから読み取れる説。
//segueのidでif文が必要になる理由がわからない
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //編集か削除か選んでもらう
        let funcAlert = UIAlertController(title: "編集or削除", message: "選択してください。", preferredStyle: .alert)
        
        
        let deleteAction = UIAlertAction(title: "削除", style: .default) { (action) in
            //削除を押すとまず確認アラートを表示する。okなら押されたセルを認知して、削除する。キャンセルなら閉じる。
            funcAlert.dismiss(animated: true, completion: nil)
            let cautionAlert = UIAlertController(title: "確認", message: "削除します。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK!", style: .default) { (action) in
                let selectedIndex = self.teacherTableView.indexPathForSelectedRow!
                self.teacherInfArray[selectedIndex.row].deleteInBackground({ (error) in
                    if error != nil{
                        print("error")
                    }else{
                        cautionAlert.dismiss(animated: true, completion: nil)
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.load()
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
            self.performSegue(withIdentifier: "toTeacherDetail", sender: nil)
            funcAlert.dismiss(animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        funcAlert.addAction(editAction)
        funcAlert.addAction(deleteAction)
        present(funcAlert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTeacherDetail"{
            let teacherDetailViewController = segue.destination as! TeacherDetailViewController
            let selectedIndex = teacherTableView.indexPathForSelectedRow!
            teacherDetailViewController.passedTeacherInf = teacherInfArray[selectedIndex.row]
        }
    }
    

}
