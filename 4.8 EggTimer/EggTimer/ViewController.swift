//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var counter = 0
    var totalCounter = 0
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    
    @IBAction func hardenessSelected(_ sender: UIButton) {
        timer?.invalidate()
        
        let hardness = sender.currentTitle!
        
        switch hardness {
        case "Soft":
            counter = 3
            totalCounter = 3
        case "Medium":
            counter = 420
            totalCounter = 420
        case "Hard":
            counter = 720
            totalCounter = 720
        default:
            print("Error")
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
            progressBar.progress = Float(counter) / Float(totalCounter)
            counterLabel.text = "\(counter) seconds to perfect egg taste"
            
        } else {
            playAlarmSound()
            counterLabel.text = "Your egg is ready \nDo you want an another delicious egg? \nTap what you want"
            timer?.invalidate()
        }
    }
    
    
    
    func playAlarmSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
                print("Ses dosyası bulunamadı.")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Ses dosyası çalınamadı: \(error.localizedDescription)")
            }
    }
    
}

