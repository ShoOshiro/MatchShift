//
//  TeacherDetailViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/09.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class TeacherDetailViewController: UIViewController {
    
    var passedTeacherInf : NCMBObject?
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var subjectTextField : UITextField!
    @IBOutlet var timeTextField : UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = passedTeacherInf?.object(forKey: "name") as? String
        subjectTextField.text = passedTeacherInf?.object(forKey: "subject") as? String
        timeTextField.text = passedTeacherInf?.object(forKey: "time") as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func update(){
        passedTeacherInf?.setObject(nameTextField.text, forKey: "name")
        passedTeacherInf?.setObject(subjectTextField.text, forKey: "subject")
        passedTeacherInf?.setObject(timeTextField.text, forKey: "time")
        passedTeacherInf?.saveInBackground({ (error) in
            if error != nil{
                print("error")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
 /*
    @IBAction func delete(){
        passedTeacherInf?.deleteInBackground({ (error) in
            if error != nil{
                print("error")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
*/

}
