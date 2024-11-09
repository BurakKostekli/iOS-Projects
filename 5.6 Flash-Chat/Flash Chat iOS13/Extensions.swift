//
//  Extensions.swift
//  Flash Chat iOS13
//
//  Created by Burak Köstekli on 7.10.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
