//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {  // Just before the view shows up on the screen
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true  // if we type just this, navBar is completely removed on app
    }
    
    override func viewWillDisappear(_ animated: Bool) {  // just before the view dissappears
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""  // for reset
        titleLabel.text = Constants.appName
    }
    

}
