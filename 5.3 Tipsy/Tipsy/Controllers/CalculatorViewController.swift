//
//  ViewController.swift
//  Tipsy
//
//  Created by Burak Köstekli on 10.08.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var tipsyBrain = TipsyBrain()
    var calculatedMoney: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STEPPER SETTINGS
        stepper.minimumValue = 2
        stepper.maximumValue = 100
        stepper.value = 2
        splitNumberLabel.text = "2"
        
        // Bill Text Field için klavye türü ve delegate ayarı
        billTextField.keyboardType = .decimalPad
        billTextField.delegate = self
        
        // Klavye dışına tıklanınca kapatmak için Tap Gesture ekleme
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Klavyeyi kapatır billTextField.endEditing(true) da yazilabilirdi.
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        dismissKeyboard() // Klavyeyi kapat
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        dismissKeyboard() // Klavyeyi kapat
        
        let splitValue = Int(sender.value)
        splitNumberLabel.text = "\(splitValue)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        var percentage = "0.0"
        
        if zeroPctButton.isSelected {
            percentage = "0.0"
        } else if tenPctButton.isSelected {
            percentage = "0.1"
        } else {
            percentage = "0.2"
        }
        
        let billValue = billTextField.text?.isEmpty == false ? billTextField.text! : "0.0"
        let splitValue = splitNumberLabel.text ?? "2"
        
        calculatedMoney = tipsyBrain.calculateTip(money: billValue, percentage: percentage, split: splitValue)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.calculatedMoney = calculatedMoney
            destinationVC.settings = tipsyBrain.getSettings()
        }
    }
    
    // Maksimum 8 karakter girişi kontrolü
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 8
    }
}
