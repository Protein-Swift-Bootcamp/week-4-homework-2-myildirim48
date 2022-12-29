//
//  Planets.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 29.12.2022.
//

import Foundation

struct Planets: Codable {
    let results: [ResultPlanet]
}

// MARK: - Result
struct ResultPlanet: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
