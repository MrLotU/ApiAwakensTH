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
    
    var arrayIndex = 0
    var category: resourceType = .null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        picker.delegate = self
        picker.dataSource = self
        self.title = category.rawValue
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
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Born"
                cell.value.text = characters[arrayIndex].birthYear
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Home"
                cell.value.text = characters[arrayIndex].homeworld
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Height"
                cell.value.text = characters[arrayIndex].height
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Eyes"
                cell.value.text = characters[arrayIndex].eyeColor
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Hair"
                cell.value.text = characters[arrayIndex].hairColor
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                return cell
            }
        case .Starship:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Name Cell", for: indexPath) as! NameTableViewCell
                cell.label.text = starships[arrayIndex].name
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Make"
                cell.value.text = starships[arrayIndex].make
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Cost"
                cell.value.text = starships[arrayIndex].cost
                cell.switcher.setTitle("Credits", forSegmentAt: 0)
                cell.switcher.setTitle("USD", forSegmentAt: 1)
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Length"
                cell.value.text = starships[arrayIndex].length
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Class"
                cell.value.text = starships[arrayIndex].starshipClass
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Crew"
                cell.value.text = starships[arrayIndex].crew
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                return cell
            }
        case .Vehicle:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Name Cell", for: indexPath) as! NameTableViewCell
                cell.label.text = vehicles[arrayIndex].name
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Make"
                cell.value.text = vehicles[arrayIndex].make
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Cost"
                cell.value.text = vehicles[arrayIndex].cost
                cell.switcher.setTitle("Credits", forSegmentAt: 0)
                cell.switcher.setTitle("USD", forSegmentAt: 1)
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Conversion Cell", for: indexPath) as! ConversionTableViewCell
                cell.title.text = "Length"
                cell.value.text = vehicles[arrayIndex].length
                cell.switcher.setTitle("Metric", forSegmentAt: 0)
                cell.switcher.setTitle("English", forSegmentAt: 1)
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Class"
                cell.value.text = vehicles[arrayIndex].vehicleClass
                return cell
            } else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath) as! DetailTableViewCell
                cell.title.text = "Crew"
                cell.value.text = vehicles[arrayIndex].crew
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                return cell
            }
        case .null:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
