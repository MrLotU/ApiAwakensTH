//
//  CatTableViewCell.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 28/02/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
