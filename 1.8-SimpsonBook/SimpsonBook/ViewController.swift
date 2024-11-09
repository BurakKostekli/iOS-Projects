//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Burak Köstekli on 11.11.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var mySimpsons = [Simpsons]() // boş bir object array'i oluşturduk. içerisinde Simpsons class'ından objectlr
    var chosenSimpson : Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        
        // Simpson Objects
        let ibo = Simpsons(name: "Ibo", job: "Teacher (Old)", image: UIImage(named: "Ibo")!)
        let veysel = Simpsons(name: "Veysel", job: "Still Flunked", image: UIImage(named: "Veysel")!)
        let umut = Simpsons(name: "Umudi", job: "Food Taxi", image: UIImage(named: "Umut")!)
        let rasul = Simpsons(name: "Rasul", job: "German Learner", image: UIImage(named: "Rasul")!)
        
        mySimpsons.append(ibo)
        mySimpsons.append(veysel)
        mySimpsons.append(umut)
        mySimpsons.append(rasul)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        // Değişiklik kısmı
        content.text = mySimpsons[indexPath.row].name
        
        cell.contentConfiguration = content
        return cell
    }
    
    // Row'a tıklayınca ne olacak kısmı
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpsons[indexPath.row] // Seçilen satırı aldık
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil) // Segue gerçekleşsin dedik
    }
    
    // Segue gerçekleşmeden hemen önce kısmı
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    


}

class Simpsons {
    
    var name: String
    var job: String
    var image: UIImage
    
    init(name: String, job: String, image: UIImage) {
        self.name = name
        self.job = job
        self.image = image
    }
}

