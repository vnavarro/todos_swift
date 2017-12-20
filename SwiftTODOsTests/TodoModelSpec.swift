//
//  TodoModelSpec.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/16/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import Quick
import Nimble
import SwiftTODOs

class TodoModelSpec : QuickSpec {
    override func spec() {
        describe("TodoModel") {
            var todo: TodoModel!
            beforeEach() {
                todo = TodoModel(content:"Sample content")
            }
            
            context("after init") {
                it("set item with given content") {
                    expect(todo.content).toNot(beEmpty())
                }
                
                it("set item with completed false by default") {
                    expect(todo.completed).toNot(beTrue())
                }
                
                it("set uuid") {
                    expect(todo.getUUID().uuidString).toNot(beEmpty())
                }
            }
            
            context("using local storage") {
                it("save/load to/from user defaults") {
                    todo.saveLocally()
                    let storedTodo = TodoModel.loadLocally(todo.getUUID())
                    expect(storedTodo!.getUUID().uuidString).to(equal(todo.getUUID().uuidString))
                }
                
                it("retrieves no object safely") {
                    let storedTodo = TodoModel.loadLocally(UUID())
                    expect(storedTodo).to(beNil())
                }
                
                it("deletes from user defaults") {
                    todo.saveLocally()
                    todo.deleteLocally()
                    expect(TodoModel.loadLocally(todo.getUUID())).to(beNil())
                }
                
                it("deletes nothing safely") {
                    let notSavedTodo = TodoModel(content:"Not in userdefaults")
                    expect(TodoModel.loadLocally(notSavedTodo.getUUID())).to(beNil())
                    notSavedTodo.deleteLocally()
                    expect(TodoModel.loadLocally(notSavedTodo.getUUID())).to(beNil())
                }
            }
        }
    }
}
