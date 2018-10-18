//
//  DetailViewController.swift
//  Food_Dome1
//
//  Created by Tu on 2018/9/29.
//  Copyright © 2018年 Tu. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var pictureImage: UIImageView!
    
    
    var food:Food?
    //闭包的返回值是可选的
    //var completionCallBack:()->()?
    //闭包是可选的
    var completionCallBack:(()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

        if (food != nil){
            nameText.text=food?.name
            addressText.text=food?.address
            pictureImage.image=food?.picture
        }
        
    }


    @IBAction func saveFood(_ sender: Any) {
        food?.name=nameText.text
        food?.address=addressText.text
        food?.picture=pictureImage.image
        completionCallBack?()
        
        _=navigationController?.popViewController(animated: true)
    }
    

    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began){self.nameText.text="LongPress"}
    }
    
    @IBAction func testbutton(_ sender: Any) {
        self.nameText.text="testbutton"
    }
    
}
