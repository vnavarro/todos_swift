//
//  TodosViewController.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/5/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    private let TODOS_LOCAL_STORAGE: String = "br.com.vnavarro.todos"
    
    //MARK: Properties
    
    @IBOutlet weak var txtFieldTodo: UITextField!    
    @IBOutlet weak var tblViewTodos: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var todosData: TodosModel = TodosModel()
    var allTodos: TodosModel = TodosModel()
    
    var completedFilter: Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldTodo.delegate = self
        if let storedTodos = TodosModel.loadLocally(TODOS_LOCAL_STORAGE) {
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let newItem = textField.text {
            let newTodo = TodoModel(content: newItem)
            todosData.list.append(newTodo)
            allTodos.list.append(newTodo)
        }
        tblViewTodos.reloadData()
        textField.text = ""
        
        todosData.saveLocally(TODOS_LOCAL_STORAGE)
    }

    //Mark: UITableViewDelegate/DataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TodoTableViewCell
        
        let todo = todosData.list[indexPath.row]
        cell.titleLabel.text = todo.content
        cell.switchCheckbox(todo.completed)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosData.list.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let todo = todosData.list[indexPath.row]
            var removeIndex = -1
            for i in 0..<allTodos.list.count {
                if allTodos.list[i].content == todo.content {
                    removeIndex = i
                    break
                }
            }
            if removeIndex != -1 {
                allTodos.list.removeAtIndex(removeIndex)
            }
            todosData.list.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            todosData.saveLocally(TODOS_LOCAL_STORAGE)
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todo = todosData.list[indexPath.row]
        todo.completed = !todo.completed
        filterTodos()
        tblViewTodos.reloadData()
        
        todosData.saveLocally(TODOS_LOCAL_STORAGE)
    }
    
    //Mark: UIToolbarDelegate
    func selectToolbarItem(completedFilter: Bool?) {
        self.completedFilter = completedFilter
        filterTodos()
        tblViewTodos.reloadData()
    }
    
    func swapTabItemsColors(selectedItem: UIBarButtonItem) {
        self.toolbar.items!.forEach({ (item: UIBarButtonItem) -> () in
            item.tintColor = UIColor(red: 216/255.0, green: 222/255.0, blue: 227/255.0, alpha: 1)
        })
        selectedItem.tintColor = UIColor(red: 127/255.0, green: 219/255.0, blue: 118/255.0, alpha: 1)
    }
    
    @IBAction func selectedToDos(sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(false)
    }
    
    @IBAction func selectedAll(sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(nil)
    }
    
    @IBAction func selectedCompleted(sender: UIBarButtonItem) {
        swapTabItemsColors(sender)
        selectToolbarItem(true)
    }
    
    //Mark: Filter todos
    func filterTodos() {
        todosData.list = allTodos.filter(completedFilter);
    }
}

