//
//  TodoLocalRepositoryTests.swift
//  SwiftTODOsTests
//
//  Created by Vitor Navarro on 2017-12-27.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import Quick
import Nimble
import SwiftTODOs

class TodoLocalRepositorySpec: QuickSpec {
    
    override func spec() {
        describe("TodoLocalRepository") {
            let todosSaveKey: String = "TodosKey"
            var todos: TodosModel!
            var repository: TodoLocalRepository!
            beforeEach() {
                repository = TodoLocalRepository()
                todos = TodosModel()
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
            }
            
            context("local storage interactions") {
                it("save/load to/from user defaults") {
                    let expectedUUID = (todos.list.first?.getUUID().uuidString)!
                    repository.saveTodos(todos, key: todosSaveKey)
                    let storedTodos = repository.loadTodos(todosSaveKey)
                    let storedUUID = storedTodos?.first?.getUUID().uuidString
                    expect(storedUUID).to(equal(expectedUUID))
                }
                
                it("retrieves no object safely") {
                    let storedTodos = repository.loadTodos("nonexistent")
                    expect(storedTodos).to(beNil())
                }
                
                it("deletes from user defaults") {
                    repository.saveTodos(todos, key: todosSaveKey)
                    repository.deleteTodos(todosSaveKey)
                    expect(repository.loadTodos(todosSaveKey)).to(beNil())
                }
                
                it("deletes nothing safely") {
                    expect(repository.loadTodos(todosSaveKey)).to(beNil())
                    repository.deleteTodos(todosSaveKey)
                    expect(repository.loadTodos(todosSaveKey)).to(beNil())
                }
            }
        }
    }
    
}

