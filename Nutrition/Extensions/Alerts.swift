//
//  Alerts.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/30/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}


// completion is optional and set to nil
// make use of this if you want to do something after the showAlert is done
// is envoked when the ok is clicked.

// UIAlertAction: alert action
