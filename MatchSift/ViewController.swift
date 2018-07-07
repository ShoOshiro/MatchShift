//
//  ViewController.swift
//  MatchSift
//
//  Created by 大城章太 on 2018/03/30.
//  Copyright © 2018年 Geeksalon. All rights reserved.
//

import UIKit
import NCMB


class ViewController:
UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    //からの可能性あり
    var returnStudent : NCMBObject?
    var returnTeacher : NCMBObject?
    var returnIndexPath : IndexPath?
    var studentShowArray = ["","","","","","","","","","","","","","","","","","","","","","","","",""]
    var teacherShowArray = ["","","","","","","","","","","","","","","","","","","","","","","","",""]
    
    @IBOutlet var siftCollectionView : UICollectionView!
    @IBOutlet var roomLabel1 : UILabel!
    @IBOutlet var roomLabel2 : UILabel!
    @IBOutlet var roomLabel3 : UILabel!
    @IBOutlet var roomLabel4 : UILabel!
    @IBOutlet var roomLabel5 : UILabel!
    @IBOutlet var roomLabel6 : UILabel!
    @IBOutlet var roomLabel7 : UILabel!
    @IBOutlet var roomLabel8 : UILabel!
    @IBOutlet var roomLabel9 : UILabel!

    var studentInfArray = [NCMBObject]()
    var studentArray1 = [NCMBObject]()
    var studentArray2 = [NCMBObject]()
    var studentArray3 = [NCMBObject]()
    var studentArray4 = [NCMBObject]()
    var studentArray5 = [NCMBObject]()
    
    
    var teacherArray1 = [NCMBObject]()
    var teacherArray2 = [NCMBObject]()
    var teacherArray3 = [NCMBObject]()
    var teacherArray4 = [NCMBObject]()
    var teacherArray5 = [NCMBObject]()
    
    //横
    var numberOfRaw = 5
    //縦
    var numberOfLine = 5
    //cellとcellの空白の大きさ
    let space: CGFloat = 1.0



    override func viewDidLoad() {
        super.viewDidLoad()
        siftCollectionView.delegate = self
        siftCollectionView.dataSource = self
        //生徒と先生のセル、カスタムセルの登録
        let nib = UINib(nibName: "SiftCollectionViewCell", bundle: Bundle.main)
        siftCollectionView.register(nib, forCellWithReuseIdentifier: "siftCell")
        // Load date
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
   //     show()
//        print(studentShowArray)
 //       print(returnStudent)
        siftCollectionView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //セルの個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRaw * numberOfLine
    }
    
    @IBAction func ready() {
        // 各次元の配列を作る
        let query  = NCMBQuery(className: "studentInf")
        query?.whereKeyExists("name")
        query?.findObjectsInBackground({ (result,error) in
            if error != nil {
                print("error")
            } else {
                let resultArray = result as! [NCMBObject]
                self.studentArray1.removeAll()
                self.studentArray2.removeAll()
                self.studentArray3.removeAll()
                self.studentArray4.removeAll()
                self.studentArray5.removeAll()
                
                for object in resultArray {
                    let objectTime = object.object(forKey: "time") as! String
                    if objectTime == "1" {
                        self.studentArray1.append(object)
                    } else if objectTime == "2" {
                        self.studentArray2.append(object)
                    } else if objectTime == "3" {
                        self.studentArray3.append(object)
                    } else if objectTime == "4" {
                        self.studentArray4.append(object)
                    } else {
                        self.studentArray5.append(object)
                    }
                }
            }
        })
        let query2  = NCMBQuery(className: "teacherzinf")
        query2?.whereKeyExists("name")
        query2?.findObjectsInBackground({ (result,error) in
            if error != nil {
                print("error")
            } else {
                let resultArray = result as! [NCMBObject]
                self.teacherArray1.removeAll()
                self.teacherArray2.removeAll()
                self.teacherArray3.removeAll()
                self.teacherArray4.removeAll()
                self.teacherArray5.removeAll()
                
                for object in resultArray {
                    let objectTime = object.object(forKey: "time") as! String
                    if objectTime == "1" {
                        self.teacherArray1.append(object)
                    } else if objectTime == "2" {
                        self.teacherArray2.append(object)
                    } else if objectTime == "3" {
                        self.teacherArray3.append(object)
                    } else if objectTime == "4" {
                        self.teacherArray4.append(object)
                    } else {
                        self.teacherArray5.append(object)
                    }
                }
            }
        })
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "siftCell", for: indexPath) as! SiftCollectionViewCell

        //studentShowArrayをシフトに表示,空でうまくいくのか？空ならnil,入っていたら代入できたらいい。値が入っていないときは、不等号は使えないが、nilチェックのif文が使える。
        //if文で生徒は分ければ1:2つくれる。
            if studentShowArray[indexPath.row] != "nil" {
                cell.studentName1.text = studentShowArray[indexPath.row]
                cell.teacherName.text = teacherShowArray[indexPath.row]
                return cell
            }else{
                return cell
            }
        
            }
    
    //コードの順番を入れ替えるのではなく、配列に値が入って入ればと言う条件を入れることで、コードを読む順番によるエラーを防いでいる。
/*        if studentArray1.count > 0 {
            // 1列目の1コマ目
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.studentName1.text = studentArray1[indexPath.row].object(forKey:"name") as? String
            if studentInfArray.count > indexPath.row + 1 {
                    cell.studentName2.text = studentArray1[indexPath.row + 1].object(forKey:"name") as? String
                }
                // cell.teacherName.text = teacherArray[indexPath.row]
                return cell
            } else {
                return cell
            }
        } else {
            return cell
        }
*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (self.view.frame.width / CGFloat(numberOfLine)) - CGFloat(space)
        let height: CGFloat = width
//        print(self.view.frame.width)
        return CGSize(width: width, height: height)
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 横スペース
        return space
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 縦スペース
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //タップされたら画面遷移
        performSegue(withIdentifier: "toMatch", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toMatch" {
            let matchViewController = segue.destination as! MatchViewController
            //どこがタップされたのかを取得する。
            let selectedIndex = siftCollectionView.indexPathsForSelectedItems![0]
            //タップされた情報を次の画面に渡す
            matchViewController.passedIndexPath = selectedIndex
            
            //matchViewController.passedArray = studentArray1だとどうなるのか？
            if selectedIndex.row >= 0 && selectedIndex.row < 5 {
  //先生と生徒の情報を渡す
                matchViewController.studentPassedArray.removeAll()
                matchViewController.teacherPassedArray.removeAll()
                
                for i in 0..<(studentArray1.count) {
                    matchViewController.studentPassedArray.append(studentArray1[i])
                }
                for i in 0..<(teacherArray1.count) {
                    matchViewController.teacherPassedArray.append(teacherArray1[i])
                }
            } else if selectedIndex.row >= 5 && selectedIndex.row < 10 {
                for i in 0..<(studentArray2.count) {
                    matchViewController.studentPassedArray.append(studentArray2[i])
                }
                for i in 0..<(teacherArray2.count) {
                    matchViewController.teacherPassedArray.append(teacherArray2[i])
                }
            } else if selectedIndex.row >= 10 && selectedIndex.row < 15 {
                for i in 0..<(studentArray3.count) {
                    matchViewController.studentPassedArray.append(studentArray3[i])
                }
                for i in 0..<(teacherArray3.count) {
                    matchViewController.teacherPassedArray.append(teacherArray3[i])
                }
            } else if selectedIndex.row >= 15 && selectedIndex.row < 20 {
                for i in 0..<(studentArray4.count) {
                    matchViewController.studentPassedArray.append(studentArray4[i])
                }
                for i in 0..<(teacherArray4.count) {
                    matchViewController.teacherPassedArray.append(teacherArray4[i])
                }
            } else if selectedIndex.row >= 20 && selectedIndex.row < 25 {
                for i in 0..<(studentArray5.count) {
                    matchViewController.studentPassedArray.append(studentArray5[i])
                }
                for i in 0..<(teacherArray5.count) {
                    matchViewController.teacherPassedArray.append(teacherArray5[i])
                }
            }
            
        }
            //なぜ studentInfarray[indexpath.row] じゃダメなのか？
            
            
                //1~5,6~10,10~15のセルにはそれぞれ１、２、３、４、のようなタグをつけることによってセルの区別をつけられるのではないか。
            //これを用いてタップされたセルの取得に応用できると思う。
            }
/*
    func show() {
        if returnStudent != nil{
           // からでもうまくいくのか
            print(returnStudent!)
            studentShowArray?[] = returnStudent!.object(forKey: "name") as! String
  //          print(returnStudent!)
            print(studentShowArray!)
            siftCollectionView.reloadData()
        }
 
    }
 */
    }
/*
 立ち上がると前に組んだ情報を表示する。
 ボタンを押すと、生徒配列を用意して、生徒をセルに表示する。
 セルをタップすると、そこに入れる先生が表示されて自分で選択できる。
 
 studentInfArray studentArray1~5 passedArray
*/
//変数を使ってスイッチを作ればいけるかも。
