//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceImageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var di1 = UIImage(named: "DiceOne")
    var di2 = UIImage(named: "DiceTwo")
    var di3 = UIImage(named: "DiceThree")
    var di4 = UIImage(named: "DiceFour")
    var di5 = UIImage(named: "DiceFive")
    var di6 = UIImage(named: "DiceSix")
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        let diceArray = [di1, di2, di3, di4, di5, di6]
        diceImageView1.image = diceArray.randomElement()!  // Ikisi de bizi ayni sonuca u
        diceImageView2.image = diceArray[Int.random(in: 0...5)]
    }
    
}

