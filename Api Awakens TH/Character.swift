//
//  Characters.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 14/03/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation

public var characters: [Character] = []

open class Character {
    let name: String
    let birthYear: String
    let hairColor: String
    let height: String
    var homeworld: String
    let eyeColor: String
    var starships: [String]
    var vehicles: [String]
    var associatedVehiclesAndStarships: [String] = []
    
    public init(name: String, birthYear: String, hairColor: String, height: String, homeworld: String, eyeColor: String, starships: [String], vehicles: [String]) {
        self.name = name
        self.birthYear = birthYear
        self.hairColor = hairColor
        self.height = height
        self.homeworld = homeworld
        self.eyeColor = eyeColor
        self.starships = starships
        self.vehicles = vehicles
    }
}
