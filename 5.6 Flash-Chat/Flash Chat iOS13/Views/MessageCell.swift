//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Burak Köstekli on 8.10.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // messageBubble.layer.cornerRadius = messageBubble.frame.height / 5   DELETED
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 5  // ADDED
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
