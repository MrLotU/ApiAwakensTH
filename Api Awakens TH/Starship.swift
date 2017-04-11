//
//  Starship.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 16/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation

public var starships: [Starship] = []

open class Starship {
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: String
    
    public init(name: String, make: String, cost: String, length: String, starshipClass: String, crew: String) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
    }
}
