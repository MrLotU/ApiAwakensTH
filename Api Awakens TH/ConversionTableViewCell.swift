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
        switcher.addTarget(self, action: #selector(converter), for: .valueChanged)
    }
    
    func converter() {
        switch switchCase {
        case .Cost:
            switch switcher.selectedSegmentIndex {
            /*1 Credit is 0,62 USD and 1 USD is 1,62 Credits( http://www.swtor.com/community/showthread.php?t=442915 )*/
            case 0/*Credits*/:
                if let numberString = value.text?.replacingOccurrences(of: " USD", with: "") {
                    let USD = Double(numberString)!
                    let credits = USD * 0.62
                    value.text = "\(round(credits*100)/100) Credits"
                }
            default/*USD*/:
                if let numberString = value.text?.replacingOccurrences(of: " Credits", with: "") {
                    let credits = Double(numberString)!
                    let USD = credits * 1.62
                    value.text = "\(round(USD*100)/100) USD"
                }
            }
        case .Size:
            switch switcher.selectedSegmentIndex {
            case 0/*Metric*/:
                if let numberString = value.text?.replacingOccurrences(of: " Inch", with: "") {
                    let inches = Double(numberString)!
                    let meters = inches * 0.0254
                    value.text = "\(round(meters*100)/100) m"
                }
            default/*English*/:
                if let numberString = value.text?.replacingOccurrences(of: " m", with: "") {
                    if let meters = Double(numberString) {
                        let inches = meters * 39.3700787
                        value.text = "\(round(inches*100)/100) Inch"
                    }
                }
            }
        case .null: break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
