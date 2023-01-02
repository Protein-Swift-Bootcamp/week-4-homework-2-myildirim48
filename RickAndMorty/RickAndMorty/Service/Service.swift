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
        let urlString = "https://rickandmortyapi.com/api/episode?page=\(page)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchCharacter(page:Int,completion: @escaping(Characters?,Error?) -> ()) {
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchPlanet(page:Int,completion: @escaping(Planets?,Error?) -> ()) {
        let urlString = "https://rickandmortyapi.com/api/location/?page=\(page)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    
    //MARK: - Search funcs
    func searchCharacters(searchTerm:String,completion:@escaping(Characters?,Error?) -> ()) {
        let urlString = "https://rickandmortyapi.com/api/character/?name=\(searchTerm)"
        
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    
    func searchEpisodes(searchTerm:String,completion:@escaping(Episodes?,Error?) -> ()){
        
        let urlString = "https://rickandmortyapi.com/api/episode/?name=\(searchTerm)"
        
        fetchGeneric(urlString: urlString, completion: completion)
    }
    func searchEpisodesNum(searchTerm:String,completion:@escaping(Episodes?,Error?) -> ()){
        
        let urlString = "https://rickandmortyapi.com/api/episode/?episode=\(searchTerm)"
        
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    func searchPlanetsByType(searchTerm:String,completion:@escaping(Planets?,Error?) -> ()){
        let urlString = "https://rickandmortyapi.com/api/location/?type=\(searchTerm)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    func searchPlanetsByName(searchTerm:String,completion:@escaping(Planets?,Error?) -> ()){
        let urlString = "https://rickandmortyapi.com/api/location/?name=\(searchTerm)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
//MARK: -Details
    
    func getCharDetails(id:Int,completion: @escaping(CharResult?,Error?) -> ()){
        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
        fetchGeneric(urlString: urlString, completion: completion)
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
