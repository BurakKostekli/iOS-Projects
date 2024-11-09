//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Burak Köstekli on 10.11.2023.
//

import UIKit

// ekstra eklemeler yaptık :
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var landmarkNames = [String]() // boş bir String dizisi oluşturduk
    var landmarkImages = [UIImage]() // Bir de resim dizisi
    
    var chosenLandmarkName = ""
    var chosenLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // bunlar gerekli :
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.append("Veysel")
        landmarkNames.append("Ibo")
        landmarkNames.append("Umut")
        landmarkNames.append("Rasul")
        
        landmarkImages.append(UIImage(named:"Veysel.png")!)
        landmarkImages.append(UIImage(named:"Ibo.png")!)
        landmarkImages.append(UIImage(named:"Umut.png")!)
        landmarkImages.append(UIImage(named:"Rasul.png")!)
    }
    
    // tableViewFunctions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        
        content.text = landmarkNames[indexPath.row] // cell'lerin de indexleri var ve 0'dan başlıyor bu özellikte bize sırayla indexleri vermesini sağlıyor, istersek resim vs de kullanabiliriz burda
        content.secondaryText = "Friend"
        cell.contentConfiguration = content
        
        return cell
    }
    
    // didSelectRowAt (Bir cell yani row seçildiğinde ne olacağının fonksiyonu)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkName = landmarkNames[indexPath.row]
        chosenLandmarkImage = landmarkImages[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // Diğer VC'deki değişkenlere etki etmek için prepare for segue :
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVc
            
            destinationVC.selectedLandmarkName = chosenLandmarkName
            destinationVC.selectedLandmarkImage = chosenLandmarkImage
        }
    }
    
    // Commit
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete { // burada . yazınca seçeneklerimiz çıkıyor, silmek istediğinde diyoruz burada yani sola çekme
            self.landmarkNames.remove(at: indexPath.row) // burada .remove kullanınca bizden indexini istiyor ki bu fonksiyonda vermiş
            self.landmarkImages.remove(at: indexPath.row)
            
            //tableView.reloadData() da diyebilirdik burada ama 1000 öğe varsa hepsi yeniden yüklenecek ne gerek var
            tableView.deleteRows(at: [indexPath], with: .fade) // Birini siliyoruz indexPath girerek ve . yazıp animasyon seçiyoruz
        }
    }
    
}

