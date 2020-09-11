//
//  Record+Method.swift
//  WhatToEat
//
//  Created by joting on 2020/9/10.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import CoreData
extension Record{
    static let entityName = "Record"
       
       static func read()->[Record]{
              //        步骤二：建立一个获取的请求
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
              //        步骤三：执行请求
              do {
                  let fetchedResults = try YJAwardManager.shared.managedObjectContext.fetch(fetchRequest) as? [Record]
                  if let results = fetchedResults {
                      return results
                  }
                  
              } catch  {
                  fatalError("读取Record失败")
              }
              return Array<Record>()
          }
          static func insert()->Record{
              let entity = NSEntityDescription.entity(forEntityName: entityName, in: YJAwardManager.shared.managedObjectContext)!
              let obj = Record.init(entity: entity, insertInto: YJAwardManager.shared.managedObjectContext)
                obj.create_date = Date()
              return obj

          }
}
