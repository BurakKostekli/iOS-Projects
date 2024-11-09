//
//  CalculatorBrain.swift
//  BMI-Calculator-LayoutPractice
//
//  Created by Burak Köstekli on 8.08.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi : BMI?
    
    mutating func calculateBMI(height : Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: UIColor.blue)
        } else if bmiValue < 25.0  {
            bmi = BMI(value: bmiValue, advice: "You're fit", color: UIColor.green)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: UIColor.red)
        }
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "Error"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
}


