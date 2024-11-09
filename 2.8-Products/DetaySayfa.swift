//
//  DetaySayfa.swift
//  Products
//
//  Created by Burak Köstekli on 25.11.2023.
//

import UIKit



class DetaySayfa: UIViewController {

    
    @IBOutlet weak var imageViewUrun: UIImageView!
    @IBOutlet weak var labelUrunAd: UILabel!
    @IBOutlet weak var labelUrunFiyat: UILabel!
    
    var urun:Urunler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let u = urun {
            self.navigationItem.title = u.ad
            imageViewUrun.image = UIImage(named: u.resim!)
            labelUrunFiyat.text = "\(u.fiyat!) ₺"
            labelUrunAd.text = u.ad
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
