//
//  ViewController.swift
//  Jest
//
//  Created by Burak Köstekli on 9.11.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
            
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func timerFunc() {
        timeLabel.text = "Time: \(counter)" // Güncel sayıyı gösterme
        counter -= 1
        
        if counter == 0 {
            timer.invalidate() // timer'ı durduruyorum
            timeLabel.text = "Time's Over"
        }
    }

    
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("button clicked")
    }
    
}




