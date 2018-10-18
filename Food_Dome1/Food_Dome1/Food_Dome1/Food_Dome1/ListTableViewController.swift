//
//  ListTableViewController.swift
//  Food_Dome1
//
//  Created by Tu on 2018/9/29.
//  Copyright © 2018年 Tu. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var foodList=[Food]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData{(list) in
            print(list)    
            self.foodList+=list
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData(completion:@escaping (_ list:[Food])->())->(){
        
        DispatchQueue.global().async {
            print("正在努力加载中...")
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM=[Food]()
            
            for i in 0..<20{
                let p=Food()
                
                p.name="美食-\(i)"
                p.address="地址-\(i)"
                p.picture=UIImage(named:"Food_Test.png")
                arrayM.append(p)
            }
            
            DispatchQueue.main.async(execute: {
                completion(arrayM)
            })
        }
    }
    
    // MARK - 控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc=segue.destination as! DetailViewController
        
        if let indexPath=sender as? IndexPath{
            vc.food=foodList[indexPath.row]
            
            vc.completionCallBack={
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }else{
            vc.completionCallBack={[weak vc] in
                guard let p=vc?.food else {
                    return
                }
                
                self.foodList.insert(p, at: 0)
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK - 代理方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text=foodList[indexPath.row].name
        cell.detailTextLabel?.text=foodList[indexPath.row].address
        
        cell.imageView?.image=foodList[indexPath.row].picture
        
        return cell
    }
}
