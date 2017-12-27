//
//  TodoLocalRepository.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-27.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import UIKit

open class TodoLocalRepository {
    
    public init() {}
    
    open func saveTodos(_ todos: TodosModel, key: String) {
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: todos.list)
        userDefaults.set(encodedData, forKey: key)
    }
    
    open func loadTodos(_ key: String) -> [TodoModel]? {
        let userDefaults = UserDefaults.standard
        if let todoData = userDefaults.object(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: todoData as! Data) as? [TodoModel]
        }
        return nil
    }
    
    open func deleteTodos(_ key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }
    
}
