//
//  Honoree+Method.swift
//  WhatToEat
//
//  Created by joting on 2020/9/10.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import CoreData
extension Honoree {
    static let entityName = "Honoree"
       
       static func read()->[Honoree]{
              //        步骤二：建立一个获取的请求
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
              //        步骤三：执行请求
              do {
                  let fetchedResults = try YJAwardManager.shared.managedObjectContext.fetch(fetchRequest) as? [Honoree]
                  if let results = fetchedResults {
                      return results
                  }
                  
              } catch  {
                  fatalError("读取Honoree失败")
              }
              return Array<Honoree>()
          }
        static func insert(_ degree:Int16,_ person:People,_ record:Record)->Honoree{
              let entity = NSEntityDescription.entity(forEntityName: entityName, in: YJAwardManager.shared.managedObjectContext)!
              let obj = Honoree.init(entity: entity, insertInto: YJAwardManager.shared.managedObjectContext)
              obj.setValues(degree,person,record)
                obj.create_date = Date()
              return obj

          }
        func setValues(_ degree:Int16,_ person:People,_ record:Record) {
            self.degree = degree
            self.person = person
            self.record = record
          }
}
