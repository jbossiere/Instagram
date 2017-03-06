//
//  InstaPostCell.swift
//  Instagram
//
//  Created by Julian Test on 3/5/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import ParseUI

class InstaPostCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
