//
//  PeopleCell.swift
//  Contactss
//
//  Created by Burak Köstekli on 25.11.2023.
//

import UIKit

class PeopleCell: UITableViewCell {
    @IBOutlet weak var labelPersonName: UILabel!
    @IBOutlet weak var labelPersonNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
