//
//  PickerTableViewCell.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 11/04/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var picker: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
