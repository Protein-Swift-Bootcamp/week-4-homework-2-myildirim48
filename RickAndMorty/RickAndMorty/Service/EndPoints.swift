//
//  EndPoints.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 29.12.2022.
//

import Foundation

//MARK: - Enum Endpoints --- Future update for app


enum endPoints {
    var urlBase : String {
        "https://rickandmortyapi.com/api/"
    }
    
    case charSearchByName
    case episodeSearchByName
    case planetSearchByname
    case fetchEpisode
    case fetchChars
    case fetchPlanets
    
    
    var path : String {
    switch self {
        case .episodeSearchByName:
            return "\(urlBase)episode/?name="
        case .charSearchByName:
            return "\(urlBase)character/?name="
        case .planetSearchByname:
            return ""
        case .fetchEpisode:
            return "https://rickandmortyapi.com/api/episode?page="
        case .fetchChars:
            return "https://rickandmortyapi.com/api/character?page="
        case .fetchPlanets:
            return "https://rickandmortyapi.com/api/location?page="
        }
    }
}


