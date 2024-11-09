//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager() // var ile oluşturmazsak delegate edemiyoruz unutma
    
    var timer: Timer? // Update--
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self // UIPicker delegates
        currencyPicker.delegate = self
        
        coinManager.delegate = self // my protocol delegate
    }

}


//MARK: - UIPicker

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Kaç tane sütun olacak (direkt 1 tane istiyoruz)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count // Kaç tane satır olacak
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]  // row sayısı 0'dan başlayıp artıyor satır sayısı kadar. burada title ları veriyoruz zaten adı titleForRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // seçilen row kaçıncıysa onu tutar ve row seçilince ne olacağını yazıyoruz
        let selectedCurrency = coinManager.currencyArray[row]

        timer?.invalidate() // last timer ends Update--
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in   // Update--
                self.coinManager.getCoinPrice(for: selectedCurrency)
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) { // bir seçenek seçilince sonrasında
                self.timer?.invalidate()                       // yenisi seçilmezse 30sn sonra dur
            }
    }
    
}


//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.currency
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
    
}
