//
//  ViewController.swift
//  Date-TimePicker
//
//  Created by Burak Köstekli on 27.11.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfSaat: UITextField!
    @IBOutlet weak var tfTarih: UITextField!
    
    var datePicker:UIDatePicker?
    var timePicker:UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        tfTarih.inputView = datePicker
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        tfSaat.inputView = timePicker
        
        if #available(iOS 13.4, *) { // iOS 13.4 ve sonrası
            datePicker?.preferredDatePickerStyle = .wheels
            timePicker?.preferredDatePickerStyle = .wheels
        }
        
        let dokunmaAlgilama = UITapGestureRecognizer(target: self, action: #selector(dokunmaAlgilamaMetod))
        view.addGestureRecognizer(dokunmaAlgilama) // Ekrana dokunulduğu zaman çalışacak
        
        datePicker?.addTarget(self, action: #selector(tarihGoster(uiDatePicker:)), for: .valueChanged) // Her değer değiştiğinde...
        timePicker?.addTarget(self, action: #selector(saatGoster(uiDatePicker:)), for: .valueChanged)
    }
    
    // OBJC
    @objc func dokunmaAlgilamaMetod() {
        view.endEditing(true)
    }

    @objc func tarihGoster(uiDatePicker:UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy" // Netten başka formatlara bakıp kullanılabilir
        let alinanTarih = format.string(from: uiDatePicker.date)
        tfTarih.text = alinanTarih
    }
    
    @objc func saatGoster(uiDatePicker:UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm" // Netten başka formatlara bakıp kullanılabilir
        let alinanSaat = format.string(from: uiDatePicker.date)
        tfSaat.text = alinanSaat
    }

}

