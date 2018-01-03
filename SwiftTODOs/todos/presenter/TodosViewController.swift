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
    
}

class TodosViewController: UIViewController, UITextFieldDelegate, TodosPresenterContract {
    
    @IBOutlet weak var todosView: TodosView!
    
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
    
    
    //MARK: Properties
    
    @IBOutlet weak var txtFieldTodo: UITextField!    
    @IBOutlet weak var tblViewTodos: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var todosData: TodosModel = TodosModel()
    var allTodos: TodosModel = TodosModel()
    
    var completedFilter: Bool? = nil
    
    var todoRepository: TodoRepository = TodoRepositoryFactory.createLocalRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todosView.presenter = self
        
        txtFieldTodo.delegate = self
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

    // MARK: UITextFieldDelegate
    func showEmptyNotAllowed() {
        UIAlertAction.presentInfoAlert(viewController: self, actionTitle: "Ok", message:"Empty values are not allowed")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtFieldTodo.isEmpty() {
            showEmptyNotAllowed()
            return
        }
        
        if let newItem = textField.text {
            let newTodo = TodoModel(content: newItem)
            todosData.list.append(newTodo)
            allTodos.list.append(newTodo)
        }
        tblViewTodos.reloadData()
        textField.text = ""
        
        todoRepository.saveTodos(todosData)
    }
    
    //Mark: UIToolbarDelegate
    func selectToolbarItem(_ completedFilter: Bool?) {
        self.completedFilter = completedFilter
        filterTodos()
        tblViewTodos.reloadData()
    }
    
    func swapTabItemsColors(_ selectedItem: UIBarButtonItem) {
        self.toolbar.items!.forEach({ (item: UIBarButtonItem) -> () in
            item.tintColor = UIColor(red: 216/255.0, green: 222/255.0, blue: 227/255.0, alpha: 1)
        })
        selectedItem.tintColor = UIColor(red: 127/255.0, green: 219/255.0, blue: 118/255.0, alpha: 1)
    }
    
    @IBAction func selectedToDos(_ sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(false)
    }
    
    @IBAction func selectedAll(_ sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(nil)
    }
    
    @IBAction func selectedCompleted(_ sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(true)
    }
    
    //Mark: Filter todos
    func filterTodos() {
        todosData.list = allTodos.filter(completedFilter);
    }
}

