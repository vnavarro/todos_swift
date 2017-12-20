//
//  TodosModel.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/16/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Foundation

open class TodosModel {
    open  var list: [TodoModel] = []

    public init() {}
    
    open func filter(_ completedFilter: Bool?) -> [TodoModel] {
        return list.filter { (TodoModel) -> Bool in
            return completedFilter == nil || TodoModel.completed == completedFilter
        }
    }
    
    open func saveLocally(_ key: String) {
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: list)
        userDefaults.set(encodedData, forKey: key)
    }

    open static func loadLocally(_ key: String) -> [TodoModel]? {
        let userDefaults = UserDefaults.standard
        if let todoData = userDefaults.object(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: todoData as! Data) as? [TodoModel]
        }
        return nil
    }

    open static func deleteLocally(_ key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }
    
    //MARK: Sample Generation
    
    open static func sample() -> [TodoModel] {
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
