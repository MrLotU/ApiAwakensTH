//
//  DetailTableViewController.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 11/04/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var category: resourceType = .null
    var arrayIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Category: \(category.rawValue)")
        switch category {
        case .Character: self.title = "Characters"
        case .Starship: self.title = "Starships"
        case .Vehicle: self.title = "Vehicles"
        default: self.title = ""
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                cell.switcher.setTitle("English", forSegmentAt: 0)
                cell.switcher.setTitle("Metric", forSegmentAt: 1)
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
            } else if indexPath.row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Picker Cell", for: indexPath) as! PickerTableViewCell
                //TODO: Add picker data
                return cell
            } else if indexPath.row == 7 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FirstLast Cell", for: indexPath) as! FirstLastTableViewCell
                //TODO: Fix sorting stuff
//                cell.smallest.text = characters.map { $0.height < $1.height }.height
//                cell.
                return cell
            }
        case .Starship: break
        case .Vehicle: break
        case .null: break
        }
        return UITableViewCell()
    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
