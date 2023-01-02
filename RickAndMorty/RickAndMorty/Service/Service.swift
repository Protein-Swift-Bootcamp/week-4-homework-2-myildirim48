//
//  Service.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 28.12.2022.
//

import Foundation
class Service {
    static let shared = Service()
//MARK: - Data fetching funcs
    
    func fetchEpisodes(page:Int,completion: @escaping(Episodes?,Error?) -> ()){
        fetchGeneric(urlString: endPoints.fetchEpisode(page).stringUrl, completion: completion)
    }
    
    func fetchCharacter(page:Int,completion: @escaping(Characters?,Error?) -> ()) {

        fetchGeneric(urlString: endPoints.fetchChars(page).stringUrl, completion: completion)
    }
    
    func fetchPlanet(page:Int,completion: @escaping(Planets?,Error?) -> ()) {
        fetchGeneric(urlString: endPoints.fetchPlanets(page).stringUrl, completion: completion)
    }
    
    
    //MARK: - Search funcs
    func searchCharacters(searchTerm:String,completion:@escaping(Characters?,Error?) -> ()) {
        
        fetchGeneric(urlString: endPoints.charSearchByName(searchTerm).stringUrl, completion: completion)
    }
    
    
    func searchEpisodes(searchTerm:String,completion:@escaping(Episodes?,Error?) -> ()){
        
        fetchGeneric(urlString: endPoints.episodeSearchByName(searchTerm).stringUrl, completion: completion)
    }
    func searchEpisodesNum(searchTerm:String,completion:@escaping(Episodes?,Error?) -> ()){
        fetchGeneric(urlString: endPoints.searchEpisodeByNum(searchTerm).stringUrl, completion: completion)
    }
    
    func searchPlanetsByType(searchTerm:String,completion:@escaping(Planets?,Error?) -> ()){
        
        fetchGeneric(urlString: endPoints.searchPlanetByType(searchTerm).urlBase, completion: completion)
    }
    
    func searchPlanetsByName(searchTerm:String,completion:@escaping(Planets?,Error?) -> ()){
        fetchGeneric(urlString: endPoints.planetSearchByname(searchTerm).stringUrl, completion: completion)
    }
//MARK: -Details
    
    func getCharDetails(id:Int,completion: @escaping(CharResult?,Error?) -> ()){
        fetchGeneric(urlString: endPoints.getCharDetail(id).stringUrl, completion: completion)
    }
    

    //Declare json by generic
    func fetchGeneric<T:Decodable>(urlString:String, completion: @escaping (T?,Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(nil,err)
                print("Error while fetching data at Service",err)
            }
            do{
                let objects = try JSONDecoder().decode(T.self, from: data!)
                //Success
                completion(objects,nil)
            }catch{
                completion(nil,err)
            }
      }.resume()
    }
}
