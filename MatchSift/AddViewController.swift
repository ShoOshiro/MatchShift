//
//  AddViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/01.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class AddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var nameTextfield : UITextField!
    @IBOutlet var subjectTextfield : UITextField!
    @IBOutlet var timeTextfield : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextfield.delegate = self
        subjectTextfield.delegate = self
        timeTextfield.delegate = self

    }
    override func viewDidAppear(_ animated: Bool) {
        //はじめにカーソルが点滅する
        nameTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //リターンキー押すとキーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    //Buttonを押した時にNiftyCloudに情報を保存する、画面が戻る。、値が入っていなかったらどうなるのか？
    @IBAction func studentSave (){
      let object = NCMBObject(className: "studentInf")
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
