//
//  MatchViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/05/21.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB

class MatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var matchTableView : UITableView!
    var teacherPassedArray = [NCMBObject]()
    var studentPassedArray = [NCMBObject]()
    var passedIndexPath : IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchTableView.dataSource = self
        matchTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentPassedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell")!
 //       print(passedArray[indexPath.row].object(forKey: "name") as? String)
        
        cell.textLabel?.text = studentPassedArray[indexPath.row].object(forKey: "name") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nav = self.navigationController!
        let infoVC = nav.viewControllers[nav.viewControllers.count-2] as! ViewController
        infoVC.studentShowArray[passedIndexPath.row] = studentPassedArray[indexPath.row].object(forKey: "name") as! String
 //       print(infoVC.returnStudent!)
        infoVC.returnIndexPath = passedIndexPath
        matchTableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
        
/*        let selectedIndex = matchTableView.indexPathForSelectedRow
        let decideStudent = passedArray[(selectedIndex?.row)!].object(forKey: "name") as! String
        let ud = UserDefaults.standard
        ud.set(decideStudent, forKey: "decideStudent")
        ud.synchronize()
 */
    }
    
    
}
