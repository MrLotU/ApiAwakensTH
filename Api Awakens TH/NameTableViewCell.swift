//
//  NameTableViewCell.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 16/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Do a barrel roll
        // Configure the view for the selected state
    }

}
