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
            var todos: TodosModel!
            beforeEach() {
                todos = TodosModel()
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
            }
            
            context("filtering todos") {
                beforeEach() {
                    todos.list.first?.completed = true;
                }
                
                it("show only yet to be done") {
                    let notCompleted = false
                    expect(todos.filter(notCompleted).count == 2).to(beTrue())
                }
                
                it("show only completed") {
                    let completed = true
                    expect(todos.filter(completed).count == 1).to(beTrue())
                }
                
                it("show all") {
                    expect(todos.filter(nil).count == 3).to(beTrue())
                }
            }
        }
    }
}
