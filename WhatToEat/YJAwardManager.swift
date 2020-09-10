//
//  YJAwardManager.swift
//  WhatToEat
//
//  Created by joting on 2020/9/10.
//  Copyright © 2020 Joting. All rights reserved.
//

import UIKit
import CoreData
class YJAwardManager:NSObject{
    @objc static let shared = YJAwardManager();
    let managedObjectContext:NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "YJAward")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {

                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container.viewContext
    }()
    //MARK:- Group
    @objc func readGroups() -> [Group]?{
        return Group.read()
    }
    @objc func insertGroup(_ name:String,_ info:String? = "",_ selected:Bool) -> Group {
        return Group.insert(name, info,selected)
    }
    @objc func deleteGroup(_ group:Group) {
        managedObjectContext.delete(group)
    }
    //MARK:- People
    @objc func readPeople() -> [People]?{
        return People.read()
    }
    @objc func insertPeople(_ name:String,_ info:String?,_ group:Group) -> People {
        return People.insert(name, info, group)
    }
    @objc func deletePeople(_ p:People) {
        managedObjectContext.delete(p)
    }
    //MARK:- Record
    @objc func readRecords() -> [Record]?{
        return Record.read()
    }
    @objc func insertRecord(_ name:String,_ info:String?) -> Record {
        return Record.insert()
    }
       
    //MARK:- Honoree
    @objc func readHonorees() -> [Honoree]?{
        return Honoree.read()
    }
    @objc func insertHonoree(_ degree:Int16) -> Honoree {
        return Honoree.insert(degree)
    }
    //MARK:- Private
    @objc func save() -> Bool{
        do {
            try managedObjectContext.save();
        } catch let error {
            print("无法保存:\(error)")
            return false
        }
        return true
    }
}
