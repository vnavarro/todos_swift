//
//  TodosViewController.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/5/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import UIKit

protocol TodosPresenterContract {
    
    func todosCount() -> Int
    func sectionsCount() -> Int
    func todo(at index: Int) -> TodoModel
    func removeTodo(at index: Int)
    func markTodoAsCompleted(at: Int)
    func createTodo(title: String)
    func viewController() -> UIViewController
    func changeVisibleTodos(completed: Bool?)
    
}

class TodosViewController: UIViewController, TodosPresenterContract {
    //MARK: Properties
    var todosData: TodosModel = TodosModel()
    var allTodos: TodosModel = TodosModel()
    
    var completedFilter: Bool? = nil
    
    var todoRepository: TodoRepository = TodoRepositoryFactory.createLocalRepository()
    
    //MARK: IBOutlets
    @IBOutlet weak var todosView: TodosView!
    
    //MARK: - TodosPresenterContract
    func changeVisibleTodos(completed: Bool?) {
        self.completedFilter = completed
        filterTodos()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
    func todosCount() -> Int {
        return todosData.list.count
    }
    
    func sectionsCount() -> Int {
        return 1
    }
    
    func todo(at index: Int) -> TodoModel {
        return todosData.list[index]
    }
    
    func removeTodo(at index: Int) {
        let todo = todosData.list[index]
        var removeIndex = -1
        for i in 0..<allTodos.list.count {
            if allTodos.list[i].content == todo.content {
                removeIndex = i
                break
            }
        }
        if removeIndex != -1 {
            allTodos.list.remove(at: removeIndex)
        }
        todosData.list.remove(at: index)
        todoRepository.saveTodos(todosData)
    }
    
    func markTodoAsCompleted(at index: Int) {
        let todo = todosData.list[index]
        todo.completed = !todo.completed
        filterTodos()
        todoRepository.saveTodos(todosData)
    }
    
    func createTodo(title: String) {
        let newTodo = TodoModel(content: title)
        todosData.list.append(newTodo)
        allTodos.list.append(newTodo)
        todoRepository.saveTodos(todosData)
    }
    
    //MARK: - Filter
    func filterTodos() {
        todosData.list = allTodos.filter(completedFilter);
    }
    
    //MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todosView.presenter = self
        
        if let storedTodos = todoRepository.loadTodos() {
            if(storedTodos.count > 0) {
                todosData.list = storedTodos
            }
        }
        else {
            todosData.list = TodosModel.sample()
        }

        allTodos.list = todosData.list
    }

}

