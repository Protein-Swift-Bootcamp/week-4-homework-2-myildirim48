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
    
    case charSearchByName(String)
    case episodeSearchByName(String)
    case planetSearchByname(String)
    case fetchEpisode(Int)
    case fetchChars(Int)
    case fetchPlanets(Int)
    case searchEpisodeByNum(String)
    case searchPlanetByType(String)
    case getCharDetail(Int)
    
    var stringUrl : String {
    switch self {
        case .episodeSearchByName(let name):
            return urlBase + "episode/?name=\(name)"
        case .charSearchByName(let name):
            return urlBase + "character/?name=\(name)"
        case .planetSearchByname(let name):
            return urlBase + "location?name=\(name)"
        case .fetchEpisode(let page):
            return urlBase + "episode?page=\(page)"
        case .fetchChars(let page):
            return urlBase + "character?page=\(page)"
        case .fetchPlanets(let page):
            return urlBase + "location?page=\(page)"
        case .searchEpisodeByNum(let num):
            return urlBase + "episode/?episode=\(num)"
        case .searchPlanetByType(let type):
            return urlBase + "location/?type=\(type)"
        case .getCharDetail(let charId):
            return urlBase + "character/\(charId)"
    }
    }

}




