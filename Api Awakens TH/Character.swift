//
//  Characters.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 14/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation

class Character {
    let name: String
    let birthYear: String
    let hairColor: String
    let height: String
    let homeworld: String
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    
    init(name: String, birthYear: String, hairColor: String, height: String, homeworld: String, species: [String], starships: [String], vehicles: [String]) {
        self.name = name
        self.birthYear = birthYear
        self.hairColor = hairColor
        self.height = height
        self.homeworld = homeworld
        self.species = species
        self.starships = starships
        self.vehicles = vehicles
    }
}
