//
//  ViewController.swift
//  calculator
//
//  Created by Burak Köstekli on 7.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // LABEL
    @IBOutlet weak var labelText: UILabel!
    
    
    // TEXTFIELDS
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    
    // BUTTONS
    
    @IBAction func buttonPlus(_ sender: Any) {
        
        if let firstNumber = Int(textField1.text!) {
            if let secondNumber = Int(textField2.text!) {
                
                let result = firstNumber + secondNumber
                labelText.text = String(result)
            }
        }
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        if let firstNumber = Int(textField1.text!) {
            if let secondNumber = Int(textField2.text!) {
                
                let result = firstNumber - secondNumber
                labelText.text = String(result)
            }
        }
    }
    
    @IBAction func buttonDivide(_ sender: Any) {
        if let firstNumber = Int(textField1.text!) {
            if let secondNumber = Int(textField2.text!) {
                
                let result = firstNumber / secondNumber
                labelText.text = String(result)
            }
        }
    }
    
    @IBAction func buttonMulti(_ sender: Any) {
        if let firstNumber = Int(textField1.text!) {
            if let secondNumber = Int(textField2.text!) {
                
                let result = firstNumber * secondNumber
                labelText.text = String(result)
            }
        }
    }
    
    // CALCULATE SECTION
    
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBAction func buttonCalculate(_ sender: Any) {
        resultWeight.text = String(Int(weightText.text!)! * 10)
        
    }
    
    @IBOutlet weak var resultWeight: UILabel!
    
    
    
}


