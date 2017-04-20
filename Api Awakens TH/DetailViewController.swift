//
//  DetailViewController.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 15/04/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeExchangeRateButton: UIButton!
    
    var arrayIndex = 0
    var category: resourceType = .null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        picker.delegate = self
        picker.dataSource = self
        self.title = category.rawValue
        changeExchangeRateButton.addTarget(self, action: #selector(changeExchangeRate), for: .touchUpInside)
        switch category {
        case .Character:
            largestLabel.text = characters.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.height), let lastHeight = Double(last.height) {
                    return firstHeight > lastHeight
                } else {
                    return first.height > last.height
                }
            }).first(where: { (char) -> Bool in
                char.height != "unknown"
            })!.name
            smallestLabel.text = characters.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.height), let lastHeight = Double(last.height) {
                    return firstHeight < lastHeight
                } else {
                    return first.height < last.height
                }
            }).first(where: { (char) -> Bool in
                char.height != "unknown"
            })!.name
        case .Starship:
            largestLabel.text = starships.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.length), let lastHeight = Double(last.length) {
                    return firstHeight > lastHeight
                } else {
                    return first.length > last.length
                }
            }).first(where: { (ship) -> Bool in
                ship.length != "unknown"
            })!.name
            smallestLabel.text = starships.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.length), let lastHeight = Double(last.length) {
                    return firstHeight < lastHeight
                } else {
                    return first.length < last.length
                }
            }).first(where: { (ship) -> Bool in
                ship.length != "unknown"
                
            })!.name
        case .Vehicle:
            largestLabel.text = vehicles.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.length), let lastHeight = Double(last.length) {
                    return firstHeight > lastHeight
                } else {
                    return first.length > last.length
                }
            }).first(where: { (vehicle) -> Bool in
                vehicle.length != "unknown"
            })!.name
            smallestLabel.text = vehicles.sorted(by: { (first, last) -> Bool in
                if let firstHeight = Double(first.length), let lastHeight = Double(last.length) {
                    return firstHeight < lastHeight
                } else {
                    return first.length < last.length
                }
            }).first(where: { (vehicle) -> Bool in
                vehicle.length != "unknown"
                
            })!.name
        case .null: break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        for cell in tableView.visibleCells {
            cell.isHighlighted = false
            cell.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80.0
        } else {
            return 44.0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch category {
        case .Character: return characters.count
        case .Starship: return starships.count
        case .Vehicle: return vehicles.count
        case.null: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch category {
        case .Character: return NSAttributedString(string: characters[row].name, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        case .Starship: return NSAttributedString(string: starships[row].name, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        case .Vehicle: return NSAttributedString(string: vehicles[row].name, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        case.null: return NSAttributedString(string: "", attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch category {
        case .Character: return characters[row].name
        case .Starship: return starships[row].name
        case .Vehicle: return vehicles[row].name
        case.null: return ""
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        arrayIndex = row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch category {
        case .Character:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Name Cell", for: indexPath) as! NameTableViewCell
                cell.label.text = characters[arrayIndex].name
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Born"
                cell.value.text = characters[arrayIndex].birthYear
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Home"
                cell.value.text = characters[arrayIndex].homeworld
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Height"
                if let height = Double(characters[arrayIndex].height) {
                    cell.value.text = "\(height / 100) m"
                } else {
                    cell.value.text = characters[arrayIndex].height
                }
                cell.switchCase = .Size
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Eyes"
                cell.value.text = characters[arrayIndex].eyeColor
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Hair"
                cell.value.text = characters[arrayIndex].hairColor
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        case .Starship:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Name Cell", for: indexPath) as! NameTableViewCell
                cell.label.text = starships[arrayIndex].name
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Make"
                cell.value.text = starships[arrayIndex].make
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Cost"
                if let cost = Double(starships[arrayIndex].cost) {
                    cell.value.text = "\(cost)" + " Credits"
                } else {
                    cell.value.text = starships[arrayIndex].cost
                }
                cell.switchCase = .Cost
                cell.switcher.setTitle("Credits", forSegmentAt: 0)
                cell.switcher.setTitle("USD", forSegmentAt: 1)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Length"
                if let length = Double(starships[arrayIndex].length) {
                    cell.value.text = "\(length)" + " m"
                } else {
                    cell.value.text = starships[arrayIndex].length
                }
                cell.switchCase = .Size
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Class"
                cell.value.text = starships[arrayIndex].starshipClass
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Crew"
                cell.value.text = starships[arrayIndex].crew
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        case .Vehicle:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Name Cell", for: indexPath) as! NameTableViewCell
                cell.label.text = vehicles[arrayIndex].name
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Make"
                cell.value.text = vehicles[arrayIndex].make
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Cost"
                cell.switchCase = .Cost
                if let cost = Double(vehicles[arrayIndex].cost) {
                    cell.value.text = "\(cost)" + " Credits"
                } else {
                    cell.value.text = vehicles[arrayIndex].cost
                }
                cell.switcher.setTitle("Credits", forSegmentAt: 0)
                cell.switcher.setTitle("USD", forSegmentAt: 1)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Length"
                cell.switchCase = .Size
                if let length = Double(vehicles[arrayIndex].length) {
                    cell.value.text = "\(length)" + " m"
                } else {
                    cell.value.text = vehicles[arrayIndex].length
                }
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Class"
                cell.value.text = vehicles[arrayIndex].vehicleClass
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Crew"
                cell.value.text = vehicles[arrayIndex].crew
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        case .null:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func changeExchangeRate() {
        performSegue(withIdentifier: "changeExchange", sender: nil)
    }
    
}
