//
//  ViewController + Ext.swift
//  NYT
//
//  Created by Alex Lebedev on 14.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true)
    }
}
