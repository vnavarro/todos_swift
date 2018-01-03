//
//  TodosView.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-28.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import UIKit

class TodosView: UIView {

    var presenter: TodosPresenterContract!
    

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




