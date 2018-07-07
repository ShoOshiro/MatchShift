//
//  StudentDetailViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/09.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class StudentDetailViewController: UIViewController {
    
    //ここは？が必要なるのか？
    var passedStudentInf : NCMBObject?
    
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var subjectTextField : UITextField!
    @IBOutlet var timeTextField : UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    //なぜasの後は！じゃなくて？なのか
        nameTextField.text = passedStudentInf?.object(forKey: "name") as? String
        subjectTextField.text = passedStudentInf?.object(forKey: "subject") as? String
        timeTextField.text = passedStudentInf?.object(forKey: "time") as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func update(){
        passedStudentInf?.setObject(nameTextField.text, forKey: "name")
        passedStudentInf?.setObject(subjectTextField.text, forKey: "subject")
        passedStudentInf?.setObject(timeTextField.text, forKey: "time")
        passedStudentInf?.saveInBackground({ (error) in
            if error != nil{
                print("error")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    /*削除はここでは行わないことにした。
    @IBAction func delete(){
        passedStudentInf?.deleteInBackground({ (error) in
            if error != nil{
                print("error")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
 */
//削除した時とかにアラートを入れよう

}
