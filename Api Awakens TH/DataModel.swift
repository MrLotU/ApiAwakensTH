//
//  DataModel.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 16/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum resourceType {
    case Character, Vehicle, Starship
    
    var rawValue: String{
        switch self {
        case .Character: return "people"
        case .Vehicle: return "vehicles"
        case .Starship: return "starships"
        }
    }
}


func createJSON(json: JSON, resource: resourceType) {
    switch resource {
    case .Character:
        if characterJSON == JSON.null {
            characterJSON = json
        } else {
            do {
                try characterJSON.merge(with: json)
            } catch {
                fatalError()
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        }
    case .Starship:
        if starshipJSON == JSON.null {
            starshipJSON = json
        } else {
            do {
                try starshipJSON.merge(with: json)
            } catch {
                fatalError()
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        }
    case .Vehicle:
        if vehicleJSON == JSON.null {
            vehicleJSON = json
        } else {
            do {
                try vehicleJSON.merge(with: json)
            } catch {
                fatalError()
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        }
    }
}

public var characterJSON: JSON = JSON.null
public var starshipJSON: JSON = JSON.null
public var vehicleJSON: JSON = JSON.null

func getJSON(resource: resourceType, url: URLConvertible? = nil) {
    if url != nil {
        Alamofire.request(url!).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                createJSON(json: json, resource: resource)
            }
        }
    } else {
        Alamofire.request("http://swapi.co/api/\(resource.rawValue)/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                createJSON(json: json, resource: resource)
            }
        }
    }
}
