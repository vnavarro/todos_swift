//
//  TodosModelSpec.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/16/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Quick
import Nimble
import SwiftTODOs

class TodosModelSpec : QuickSpec {
    override func spec() {
        describe("TodosModel") {
            let todosSaveKey: String = "TodosKey"
            var todos: TodosModel!
            beforeEach() {
                todos = TodosModel()
                todos.list.append(TodoModel(content:"Sample content"))
            }
            
            context("using local storage") {
                it("save/load to/from user defaults") {
                    let expectedUUID = (todos.list.first?.getUUID().UUIDString)!
                    todos.saveLocally(todosSaveKey)
                    let storedTodos = TodosModel.loadLocally(todosSaveKey)
                    let storedUUID = storedTodos?.first?.getUUID().UUIDString
                    expect(storedUUID).to(equal(expectedUUID))
                }
                
                it("retrieves no object safely") {
                    let storedTodos = TodosModel.loadLocally("nonexistent")
                    expect(storedTodos).to(beNil())
                }
                
                it("deletes from user defaults") {
                    todos.saveLocally(todosSaveKey)
                    TodosModel.deleteLocally(todosSaveKey)
                    expect(TodosModel.loadLocally(todosSaveKey)).to(beNil())
                }
                
                it("deletes nothing safely") {
                    let notSavedTodos = TodoModel(content:"Not in userdefaults")
                    expect(TodosModel.loadLocally(todosSaveKey)).to(beNil())
                    TodosModel.deleteLocally(todosSaveKey)
                    expect(TodosModel.loadLocally(todosSaveKey)).to(beNil())
                }
            }
        }
    }
}