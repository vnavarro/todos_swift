//
//  TodosModel.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/16/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Foundation

public class TodosModel {
    public  var list: [TodoModel] = []

    public init() {}
    
    public func filter(completedFilter: Bool?) -> [TodoModel] {
        return list.filter { (TodoModel) -> Bool in
            return completedFilter == nil || TodoModel.completed == completedFilter
        }
    }
    
    public func saveLocally(key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(list)
        userDefaults.setObject(encodedData, forKey: key)
    }

    public static func loadLocally(key: String) -> [TodoModel]? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let todoData = userDefaults.objectForKey(key) {
            return NSKeyedUnarchiver.unarchiveObjectWithData(todoData as! NSData) as? [TodoModel]
        }
        return nil
    }

    public static func deleteLocally(key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(key)
    }
    
    //MARK: Sample Generation
    
    public static func sample() -> [TodoModel] {
        var data = [TodoModel]()
        data.append(TodoModel(content:"Pay the bills"))
        data.append(TodoModel(content:"Fix bike"))
        data.append(TodoModel(content:"Schedule Medic"))
        data.append(TodoModel(content:"Get more dog food"))
        data.append(TodoModel(content:"Call jenny to schedule dinner"))
        data.append(TodoModel(content:"Invite Bob to play basket"))
        data.append(TodoModel(content:"Buy ticket to see this week Golden State game"))
        return data
    }
}