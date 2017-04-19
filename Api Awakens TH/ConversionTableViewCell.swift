//
//  ConversionTableViewCell.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 11/04/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

enum switchCase {
    case Size, Cost, null
}

class ConversionTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var switcher: UISegmentedControl!
    var switchCase: switchCase = .null
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switcher.addTarget(self, action: #selector(converter), for: .touchUpInside)
    }
    
    func converter() {
        switch switchCase {
        case .Cost:
            switch switcher.selectedSegmentIndex {
            /*1 Credit is 0,62 USD and 1 USD is 1,62 Credits( http://www.swtor.com/community/showthread.php?t=442915 )*/
            case 0/*Credits*/:
                let USD = Double(value.text!)!
                let credits = USD * 0.62
                value.text = "\(credits)"
            default/*USD*/:
                let credits = Double(value.text!)!
                let USD = credits * 0.62
                value.text = "\(USD)"
            }
        case .Size:
            switch switcher.selectedSegmentIndex {
            case 0/*Metric*/:
                let inches = Double(value.text!)!
                let meters = inches * 2.54
                value.text = "\(meters)"
            default/*English*/:
                let meters = Double(value.text!)!
                let inches = meters * 0.393700787
                value.text = "\(inches)"
            }
        case .null: break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
