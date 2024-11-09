//
//  TableViewController.swift
//  Challange1
//
//  Created by Burak Köstekli on 30.12.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    var flagNames: [String] = [] // var flagNames = [String]()      ikisi de olur
    var flags: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                flagNames.append(item)
            }
        }
        flagNames.sort()
        
    }

    

}


extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        // Ülke ismini alma : Fazlalıkları Kırpma
        let flagName = flagNames[indexPath.row]
        let first = flagName.index(flagName.startIndex, offsetBy: 4)
        let last = flagName.index(flagName.endIndex, offsetBy: -4)
        let resultName = flagName[first..<last]
        flags.append(String(resultName))                    // Diğer VC'ye ismini de göndereyim dedim, baştan işlem yapmayalım dosya ismini törpülemek için diğer vc'de
        
        content.text = String(resultName)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flagNames[indexPath.row]
            vc.imageName = "\(flags[indexPath.row]) - \(indexPath[1]) of \(flagNames.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



