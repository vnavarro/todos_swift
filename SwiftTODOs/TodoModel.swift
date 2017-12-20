//
//  TodoModel.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/6/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Foundation

open class TodoModel: NSObject, NSCoding {
    fileprivate var uuid: UUID
    open  var content: String
    open  var completed: Bool
    
    open func getUUID() -> UUID {
        return self.uuid;
    }
    
    public init (content: String) {
        self.uuid = UUID()
        self.content = content
        self.completed = false
    }
    
    //MARK: NSCoding
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: "uuid")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(completed, forKey: "completed")
    }
    
    public required init(coder aDecoder: NSCoder) {
        uuid = aDecoder.decodeObject(forKey: "uuid") as! UUID
        content = aDecoder.decodeObject(forKey: "content") as! String
        completed = aDecoder.decodeBool(forKey: "completed")
    }
    
    //MARK: Local Storage
    
    open func saveLocally() {
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self);
        userDefaults.set(encodedData, forKey: self.uuid.uuidString)
    }
    
    open static func loadLocally(_ uuid: UUID) -> TodoModel? {
        let userDefaults = UserDefaults.standard
        if let todoData = userDefaults.object(forKey: uuid.uuidString) {
            return NSKeyedUnarchiver.unarchiveObject(with: todoData as! Data) as? TodoModel
        }
        return nil
    }
    
    open func deleteLocally() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: self.uuid.uuidString)
    }
}
