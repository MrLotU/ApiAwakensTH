//
//  Starship.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 16/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation

class Starship {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
}
