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
            var todo: TodoModel!
            var repository: TodoLocalRepository!
            
            beforeEach() {
                repository = TodoLocalRepository()
                todos = TodosModel()
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
                todos.list.append(TodoModel(content:"Sample content"))
                
                todo = TodoModel(content:"Sample content")
            }
            
            context("todos storage interactions with default key") {
                it("save/load to/from user defaults") {
                    let expectedUUID = (todos.list.first?.getUUID().uuidString)!
                    repository.saveTodos(todos)
                    let storedTodos = repository.loadTodos()
                    let storedUUID = storedTodos?.first?.getUUID().uuidString
                    expect(storedUUID).to(equal(expectedUUID))
                }
                
                it("retrieves no object safely") {
                    repository.deleteTodos()
                    let storedTodos = repository.loadTodos()
                    expect(storedTodos).to(beNil())
                }
                
                it("deletes from user defaults") {
                    repository.saveTodos(todos)
                    repository.deleteTodos()
                    expect(repository.loadTodos()).to(beNil())
                }
                
                it("deletes nothing safely") {
                    expect(repository.loadTodos()).to(beNil())
                    repository.deleteTodos()
                    expect(repository.loadTodos()).to(beNil())
                }
            }
            
            context("todos storage interactions with custom key") {
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
            
            context("todo storage interactions") {
                it("save/load to/from user defaults") {
                    repository.saveTodo(todo)
                    let storedTodo = repository.loadTodo(todo.getUUID())
                    expect(storedTodo!.getUUID().uuidString).to(equal(todo.getUUID().uuidString))
                }
                
                it("retrieves no object safely") {
                    let storedTodo = repository.loadTodo(UUID())
                    expect(storedTodo).to(beNil())
                }
                
                it("deletes from user defaults") {
                    repository.saveTodo(todo)
                    repository.deleteTodo(todo)
                    expect(repository.loadTodo(todo.getUUID())).to(beNil())
                }
                
                it("deletes nothing safely") {
                    let notSavedTodo = TodoModel(content:"Not in userdefaults")
                    expect(repository.loadTodo(notSavedTodo.getUUID())).to(beNil())
                    repository.deleteTodo(notSavedTodo)
                    expect(repository.loadTodo(notSavedTodo.getUUID())).to(beNil())
                }
            }
        }
    }
    
}

