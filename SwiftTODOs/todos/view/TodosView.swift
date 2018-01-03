//
//  TodosView.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-28.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import UIKit

class TodosView: UIView {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var presenter: TodosPresenterContract!
    
    func showEmptyNotAllowed() {
        UIAlertAction.presentInfoAlert(viewController: presenter.viewController(), actionTitle: "Ok", message:"Empty values are not allowed")
    }
    
}

extension TodosView: UIToolbarDelegate {
    
    //Mark: UIToolbarDelegate
    func selectToolbarItem(_ completedFilter: Bool?) {
        presenter.changeVisibleTodos(completed: completedFilter)
        tableView.reloadData()
    }
    
    func swapTabItemsColors(_ selectedItem: UIBarButtonItem) {
        toolbar.items!.forEach({ (item: UIBarButtonItem) -> () in
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
    
}

extension TodosView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty() {
            showEmptyNotAllowed()
            return
        }
        
        if let newItem = textField.text {
            presenter.createTodo(title: newItem)
        }
        tableView.reloadData()
        textField.text = ""
    }
    
}

extension TodosView:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.todosCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TodoTableViewCell
        
        let todo = presenter.todo(at: indexPath.row)
        cell.titleLabel.text = todo.content
        cell.switchCheckbox(todo.completed)
        
        return cell
    }
    
}

extension TodosView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            presenter.removeTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.markTodoAsCompleted(at: indexPath.row)
        tableView.reloadData()
    }
    
}




