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
