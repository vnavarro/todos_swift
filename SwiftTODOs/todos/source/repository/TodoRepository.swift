//
//  TodoRepository.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-28.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import Foundation

public protocol TodoRepository {

    func saveTodos(_ todos: TodosModel, key: String)
    func loadTodos(_ key: String) -> [TodoModel]?
    func deleteTodos(_ key: String)
    
}

open class TodoRepositoryFactory {
    
    open static func createLocalRepository() -> TodoRepository {
        return TodoLocalRepository()
    }
    
}
