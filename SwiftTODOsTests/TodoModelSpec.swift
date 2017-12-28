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
        }
    }
}
