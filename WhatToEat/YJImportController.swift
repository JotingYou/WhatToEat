//
//  YJImportController.swift
//  WhatToEat
//
//  Created by joting on 2020/9/11.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import SwiftyJSON
class YJImportController: UIViewController {
    @objc var group:Group?
    
    @IBOutlet weak var textView: UITextView!

    @IBAction func importData(_ sender: Any) {
        if jsonToDatabase(self.textView.text) {
            self.navigationController!.popViewController(animated: true)
        }else{
            YJProgressHUD.showError("数据导入失败，请检查格式");
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.layer.cornerRadius = 10
        self.textView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    func jsonToDatabase(_ string:String)->Bool{
        if string == "" {
            return false
        }
        guard let jsonData:Data = string.data(using: .utf8) else {
            return false
        }
        do{
            let json = try JSON(data: jsonData)
            var ma:Array<Dictionary<String,String>> = Array()
            for i in 0 ..< json.count {
                guard let name:String = json[i]["name"].string else {
                    print(json[i]["name"])
                    return false
                }
                guard let info:String = json[i]["info"].string else {
                    print(json[i]["info"])
                    return false
                }
                guard let tel:String = json[i]["tel"].string else {
                    print(json[i]["tel"])
                    return false
                }
                let dic = ["name":name,"info":info,"tel":tel]
                ma.append(dic)
            }
            for dic in ma {
                if let g:Group = group {
                    YJAwardManager.shared.insertPeople(dic["name"]!, dic["info"] ?? nil, dic["tel"]!,g)
                }else{
                    return false
                }
            }
        }catch{
              return false
        }
        return YJAwardManager.shared.save()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
