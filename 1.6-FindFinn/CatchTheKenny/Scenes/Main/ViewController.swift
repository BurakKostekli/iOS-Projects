//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Burak Köstekli on 9.11.2023.
//
//MVVM - MVVM-C -
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var userScoreLabel: UILabel!
    @IBOutlet private weak var highScoreLabel: UILabel!
    @IBOutlet private weak var fin1: UIImageView!
    @IBOutlet private weak var fin2: UIImageView!
    @IBOutlet private weak var fin3: UIImageView!
    @IBOutlet private weak var fin4: UIImageView!
    @IBOutlet private weak var fin5: UIImageView!
    @IBOutlet private weak var fin6: UIImageView!
    @IBOutlet private weak var fin7: UIImageView!
    @IBOutlet private weak var fin8: UIImageView!
    @IBOutlet private weak var fin9: UIImageView!
    
    // Variables
    var userScore = 0
    var timer = 10;
    var timerMain = Timer()
    var timerImage = Timer()
    
    var finnArray: [UIImageView] = []
    var highScore = 0
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        // Image Touch
        finnArray = [fin1, fin2, fin3, fin4, fin5, fin6, fin7, fin8, fin9]
            for imageView in finnArray {
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scorePlus))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(gestureRecognizer)
            }
        displayScore()
        
        // Main Timer
        timerMain = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainTime), userInfo: nil, repeats: true)
        // Image Timer
        timerImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFinn), userInfo: nil, repeats: true)
        
        hideFinn()
    }
    
    
    // Functions


}

// Access Control
// private
// ınternal- defaualt
// fileprivate
// public

private extension ViewController {
    
    func displayScore() {
        userScoreLabel.text = "Score: \(userScore)"
    }
}

// MARK: - Action

extension ViewController {
    
    @objc func hideFinn() {
        for finn in finnArray {
            finn.isHidden = true // hiçbiri görünmüyorda tıklanmıyorda
        }
        
        let random = Int(arc4random_uniform(UInt32(finnArray.count - 1)))
        finnArray[random].isHidden = false
    }
    
    @objc func mainTime() {
        timer -= 1
        timeLabel.text = String(timer)
        
        if timer == 0 {
            timeLabel.text = "Time's Over"
            timerMain.invalidate()
            timerImage.invalidate()
            
            // HighScore Save
            if self.userScore > self.highScore {
                self.highScore = self.userScore
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
            
            // Game over hide all finns
            for finn in finnArray {
                finn.isHidden = true // hiçbiri görünmüyorda tıklanmıyorda
            }
            
            // ALERT
            let alertEnd = UIAlertController(title: "Time is Over", message: "Do you want to restart?", preferredStyle: UIAlertController.Style.alert)
            let alertEndButton = UIAlertAction(title: "Restart", style: UIAlertAction.Style.default) { UIAlertAction in
                
                // Restart Game
                self.userScore = 0
                self.userScoreLabel.text = "Score: \(self.userScore)"
                self.timer = 10
                self.timeLabel.text = String(self.timer)
                
                // Timer'ları yeniden aynı şekilde tanımlayarak baştan başlatıyoruz :
                self.timerMain = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.mainTime), userInfo: nil, repeats: true)
                
                self.timerImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFinn), userInfo: nil, repeats: true)
                
            }
            
            let alertQuitButton = UIAlertAction(title: "Quit", style: UIAlertAction.Style.cancel) { UIAlertAction in
                // Quit App Code
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
            }
            
            alertEnd.addAction(alertEndButton)
            alertEnd.addAction(alertQuitButton)
            
            self.present(alertEnd, animated: true, completion: nil)
        }
    }
    
    @objc func scorePlus() {
        userScore += 1
        displayScore()
        print(userScore)
    }
}
