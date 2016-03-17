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
                    expect(todo.getUUID().UUIDString).toNot(beEmpty())
                }
            }
            
            context("using local storage") {
                it("save/load to/from user defaults") {
                    todo.saveLocally()
                    let storedTodo = TodoModel.loadLocally(todo.getUUID())
                    expect(storedTodo!.getUUID().UUIDString).to(equal(todo.getUUID().UUIDString))
                }
                
                it("retrieves no object safely") {
                    let storedTodo = TodoModel.loadLocally(NSUUID())
                    expect(storedTodo).to(beNil())
                }
            }
        }
    }
}
