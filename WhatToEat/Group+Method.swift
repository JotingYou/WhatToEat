//
//  Group+Method.swift
//  WhatToEat
//
//  Created by joting on 2020/9/10.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import CoreData
extension Group {
    static let entityName = "Group"
    
    static func read()->[Group]{
           //        步骤二：建立一个获取的请求
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
           //        步骤三：执行请求
           do {
               let fetchedResults = try YJAwardManager.shared.managedObjectContext.fetch(fetchRequest) as? [Group]
               if let results = fetchedResults {
                   return results
               }
               
           } catch  {
               fatalError("读取Group失败")
           }
           return Array<Group>()
       }
    static func insert(_ name:String,_ info:String?,_ selected:Bool?)->Group{
           let entity = NSEntityDescription.entity(forEntityName: entityName, in: YJAwardManager.shared.managedObjectContext)!
           let obj = Group.init(entity: entity, insertInto: YJAwardManager.shared.managedObjectContext)
           obj.setValues(name,info,selected)
        obj.create_date = Date()
           return obj

       }
    func setValues(_ name:String,_ info:String?,_ selected:Bool?) {
        self.name = name
        self.info = info
        self.selected = selected ?? false
       }
}
