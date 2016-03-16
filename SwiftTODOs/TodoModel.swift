//
//  TodoModel.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/6/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Foundation

public class TodoModel {
    public var content: String
    public var completed: Bool
    
    public init (content: String) {
        self.content = content
        self.completed = false
    }
    
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