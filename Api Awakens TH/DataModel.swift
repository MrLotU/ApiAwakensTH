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

func get(for_resource resource: resourceType) -> DataRequest {
    let url: URL = URL(string: "http://swapi.co/api/\(resource.rawValue)/"/*?format=json"*/)!
    print(url)
    let data = Alamofire.request(url)
    return data
}
