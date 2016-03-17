//
//  TodoModel.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/6/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Foundation

public class TodoModel: NSObject, NSCoding {
    private var uuid: NSUUID
    public  var content: String
    public  var completed: Bool
    
    public func getUUID() -> NSUUID {
        return self.uuid;
    }
    
    public init (content: String) {
        self.uuid = NSUUID()
        self.content = content
        self.completed = false
    }
    
    //MARK: NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uuid, forKey: "uuid")
        aCoder.encodeObject(content, forKey: "content")
        aCoder.encodeBool(completed, forKey: "completed")
    }
    
    public required init(coder aDecoder: NSCoder) {
        uuid = aDecoder.decodeObjectForKey("uuid") as! NSUUID
        content = aDecoder.decodeObjectForKey("content") as! String
        completed = aDecoder.decodeBoolForKey("completed")
    }
    
    //MARK: Local Storage
    
    public func saveLocally() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(self);
        userDefaults.setObject(encodedData, forKey: self.uuid.UUIDString)
    }
    
    public static func loadLocally(uuid: NSUUID) -> TodoModel? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let todoData = userDefaults.objectForKey(uuid.UUIDString) {
            return NSKeyedUnarchiver.unarchiveObjectWithData(todoData as! NSData) as? TodoModel
        }
        return nil
    }
    
    public func deleteLocally() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(self.uuid.UUIDString)
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