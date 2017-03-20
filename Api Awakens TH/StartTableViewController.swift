//
//  StartTableViewController.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 28/02/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StartTableViewController: UITableViewController {
    
    let categories = ["Characters", "Vehicles", "Starships"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Characters: \(get(for_resource: .Character))")
        print("-----------------------------")
        print("Starships: \(get(for_resource: .Starship))")
        print("-----------------------------")
        print("Vehicle: \(get(for_resource: .Vehicle))")

        let vehiclesData = get(for_resource: .Vehicle)
        var vehiclesJSON: JSON {
            var json: JSON = JSON.null
            vehiclesData.responseJSON { (response) in
                print(response.value!)
                json = JSON(response.value!)
            }
            return json
        }
        print(vehiclesJSON)
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
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatTableViewCell
        
        cell.catNameLabel.text = categories[indexPath.row]
        switch categories[indexPath.row] {
        case "Characters":
            cell.catImageView.image = UIImage(named: "icon-characters")
        case "Vehicles":
            cell.catImageView.image = UIImage(named: "icon-vehicles")
        default:
            cell.catImageView.image = UIImage(named: "icon-starships")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/3
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
