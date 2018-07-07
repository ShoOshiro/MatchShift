//
//  TeacherAddViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/05.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class TeacherAddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var nameTextfield : UITextField!
    @IBOutlet var subjectTextfield : UITextField!
    @IBOutlet var timeTextfield : UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextfield.delegate = self
        subjectTextfield.delegate = self
        timeTextfield.delegate = self

        // Do any additional setup after loading the view.
    }
    
    //画面が立ち上がると点滅する。
    override func viewDidAppear(_ animated: Bool) {
        nameTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func studentSave (){
        let object = NCMBObject(className: "teacherInf")
        object?.setObject(nameTextfield.text, forKey: "name")
        object?.setObject(subjectTextfield.text, forKey: "subject")
        object?.setObject(timeTextfield.text, forKey: "time")
        object?.saveInBackground({ (error) in
            if error != nil{
                print("error")
            }else{
                print("success")
                //画面戻る、modalの時はdismissで戻るのか、popview~で戻るのか
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
   

}
