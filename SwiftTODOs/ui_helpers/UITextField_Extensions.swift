//
//  UITextField_Extensions.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-27.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import UIKit

extension UITextField {
    
    func isEmpty() -> Bool {
        return (text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
