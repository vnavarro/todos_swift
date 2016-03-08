//
//  TodoTableViewCell.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 3/6/16.
//  Copyright © 2016 Vitor Navarro. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func switchCheckbox(checked: Bool) {
        if checked {
            checkboxImg.image = UIImage(named: "checked")
        }
        else {
            checkboxImg.image = UIImage(named: "unchecked")
        }
    }

}
