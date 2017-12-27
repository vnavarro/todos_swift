//
//  UIAlertAction+Extensions.swift
//  SwiftTODOs
//
//  Created by Vitor Navarro on 2017-12-20.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import UIKit

extension UIAlertAction {
    
    /**
     * Create an Informative UIAlertController and present it in the given view controller with button (action) title and a message.
     * @parameter viewController The UIViewController to present the Alert
     * @parameter actionTitle A String for the action button title
     * @parameter message A String for UIAlertController message
     **/
    static func presentInfoAlert(viewController: UIViewController, actionTitle: String, message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
