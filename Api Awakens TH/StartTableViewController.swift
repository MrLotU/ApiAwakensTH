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
        getJSON(resource: .Character)
        getJSON(resource: .Starship)
        getJSON(resource: .Vehicle)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        for cell in tableView.visibleCells {
            cell.isHighlighted = false
            cell.isSelected = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.scrollToRow(at: IndexPath(row: 2, section: 0) , at: .bottom, animated: false)
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
        return view.bounds.height/3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if characterJSON == JSON.null {
            getJSON(resource: .Character)
            return
        } else if vehicleJSON == JSON.null {
            getJSON(resource: .Vehicle)
            return
        } else if starshipJSON == JSON.null {
            getJSON(resource: .Starship)
            return
        }
        switch categories[indexPath.row] {
        case "Characters":
            self.performSegue(withIdentifier: "showDetail", sender: resourceType.Character)
        case "Vehicles":
            self.performSegue(withIdentifier: "showDetail", sender: resourceType.Vehicle)
        case "Starships":
            self.performSegue(withIdentifier: "showDetail", sender: resourceType.Starship)
        default:
            print("Something went wrong")
        }

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.category = sender as! resourceType
        }
    }

}
