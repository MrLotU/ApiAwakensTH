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

public var characterJSON: JSON = JSON.null
public var starshipJSON: JSON = JSON.null
public var vehicleJSON: JSON = JSON.null
public var exchangeDollarsToCredits: Double = 0.62
public var exchangeCreditsToDollars: Double = 1.62

enum ApiAwakensError: Error {
    case ExchangeError(onExchangeValue: String)
}

enum resourceType {
    case Character, Vehicle, Starship, null
    
    var urlValue: String {
        switch self {
        case .Character: return "people"
        case .Vehicle: return "vehicles"
        case .Starship: return "starships"
        case .null: return "null"
        }
    }
    var rawValue: String {
        switch  self {
        case .Character: return "Characters"
        case .Vehicle: return "Vehicles"
        case .Starship: return "Starships"
        case .null: return "null, how did you even get this?"
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
                print("Failed to merge!")
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        } else {
            if let results = characterJSON["results"].array {
                for result in results {
                    guard let name = result["name"].string else {return}
                    guard let birthYear = result["birth_year"].string else {return}
                    guard let hairColor = result["hair_color"].string else {return}
                    guard let height = result["height"].string else {return}
                    guard let homeworld = result["homeworld"].string else {return}
                    guard let eyeColor = result["eye_color"].string else {return}
                    var starships: [String] = []
                    if let starshipsArray = result["starships"].arrayObject {
                        starships = starshipsArray.map {"\($0)"}
                    }
                    var vehicles: [String] = []
                    if let vehiclesArray = result["vehicles"].arrayObject {
                        vehicles = vehiclesArray.map {"\($0)"}
                    }
                    let character = Character(name: name, birthYear: birthYear, hairColor: hairColor, height: height, homeworld: homeworld, eyeColor: eyeColor, starships: starships, vehicles: vehicles)
                    getPlanet(forCharacter: character)
                    getAssociatedVehiclesAndStarships(forCharacter: character)
                    characters.append(character)
                }
            }
        }
    case .Starship:
        if starshipJSON == JSON.null {
            starshipJSON = json
        } else {
            do {
                try starshipJSON.merge(with: json)
            } catch {
                fatalError("Failed to merge!")
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        } else {
            if let results = starshipJSON["results"].array {
                for result in results {
                    guard let name = result["name"].string else {return}
                    guard let make = result["manufacturer"].string else {return}
                    guard let cost = result["cost_in_credits"].string else {return}
                    guard var length = result["length"].string else {return}
                    guard let starshipClass = result["starship_class"].string else {return}
                    guard let crew = result["crew"].string else {return}
                    //Ugly solution because this was the only case in the entire API where the length had a , instead of just being all numbers
                    if name == "Star Destroyer" {
                        length = length.replacingOccurrences(of: ",", with: "")
                    }
                    let starship = Starship(name: name, make: make, cost: cost, length: length, starshipClass: starshipClass, crew: crew)
                    starships.append(starship)
                }
            }
        }
    case .Vehicle:
        if vehicleJSON == JSON.null {
            vehicleJSON = json
        } else {
            do {
                try vehicleJSON.merge(with: json)
            } catch {
                fatalError("Failed to merge!")
            }
        }
        if let url = json["next"].string {
            getJSON(resource: resource, url: url)
        } else {
            if let results = vehicleJSON["results"].array {
                for result in results {
                    guard let name = result["name"].string else {return}
                    guard let make = result["manufacturer"].string else {return}
                    guard let cost = result["cost_in_credits"].string else {return}
                    guard let length = result["length"].string else {return}
                    guard let vehicleClass = result["vehicle_class"].string else {return}
                    guard let crew = result["crew"].string else {return}
                    let vehicle = Vehicle(name: name, make: make, cost: cost, length: length, vehicleClass: vehicleClass, crew: crew)
                    vehicles.append(vehicle)
                }
            }
        }
    default: break
    }
}


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
        Alamofire.request("http://swapi.co/api/\(resource.urlValue)/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                createJSON(json: json, resource: resource)
            }
        }
    }
}

func getAssociatedVehiclesAndStarships(forCharacter character: Character) {
    for starship in character.starships {
        Alamofire.request(starship).responseJSON { (responseData) -> Void in
            if responseData.result.value != nil {
                let json = JSON(responseData.result.value!)
                guard let name = json["name"].string else {
                    print("Failed to get starship for \(character.name)")
                    return
                }
                character.associatedVehiclesAndStarships.append(name)
            }
        }
    }
    for vehicle in character.vehicles {
        Alamofire.request(vehicle).responseJSON { (responseData) -> Void in
            if responseData.result.value != nil {
                let json = JSON(responseData.result.value!)
                guard let name = json["name"].string else {
                    print("Failed to get vehicle for \(character.name)")
                    return
                }
                character.associatedVehiclesAndStarships.append(name)
            }
        }

    }
}

func getPlanet(forCharacter character: Character) {
    Alamofire.request(character.homeworld).responseJSON {
        (responseData) -> Void in
        if responseData.result.value != nil {
            let json = JSON(responseData.result.value!)
            guard let name = json["name"].string else {
                print("Failed to get planet for \(character.name)")
                return
            }
            character.homeworld = name
        }
    }
}






