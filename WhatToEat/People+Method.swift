//
//  People+Method.swift
//  WhatToEat
//
//  Created by joting on 2020/9/10.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import CoreData
extension People {
    static func read()->[People]{
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        //        步骤三：执行请求
        do {
            let fetchedResults = try YJAwardManager.shared.managedObjectContext.fetch(fetchRequest) as? [People]
            if let results = fetchedResults {
                return results
            }
            
        } catch  {
            fatalError("读取People失败")
        }
        return Array<People>()
    }
    static func insert(_ name:String,_ info:String?,_ tel:String?,_ group:Group)->People{
        let entity = NSEntityDescription.entity(forEntityName: "People", in: YJAwardManager.shared.managedObjectContext)!
        let person = People.init(entity: entity, insertInto: YJAwardManager.shared.managedObjectContext)
        person.setValues(name,info,tel,group)
        person.create_date = Date()
        return person

    }
    func setValues(_ name:String,_ info:String?,_ tel:String?,_ group:Group) {
        self.name = name
        self.info = info
        self.group = group
        self.tel = tel
    }
}
