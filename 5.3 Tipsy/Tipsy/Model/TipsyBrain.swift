//
//  TipsyBrain.swift
//  Tipsy
//
//  Created by Burak Köstekli on 11.08.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct TipsyBrain {
    private var bill: Float = 0.0
    private var tipPercentage: Float = 0.0
    private var split: Int = 2
    
    mutating func calculateTip(money: String, percentage: String, split: String) -> String {
        let billString = money.replacingOccurrences(of: ",", with: ".")
        bill = Float(billString) ?? 0.0
        tipPercentage = Float(percentage) ?? 0.0
        self.split = Int(split) ?? 2
        
        let totalPerPerson = ((bill * tipPercentage) + bill) / Float(self.split)
        return String(format: "%.2f", totalPerPerson)
    }
    
    func getSettings() -> String {
        return "Split between \(split) people, with \(Int(tipPercentage * 100))% tip."
    }
}




