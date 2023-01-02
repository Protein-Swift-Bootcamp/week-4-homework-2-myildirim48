//
//  PlanetsVC.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class PlanetsVC: UIViewController {
    
    @IBOutlet weak var planetSearchBar: UISearchBar!
    @IBOutlet weak var planetWarningLabel: UILabel!
    @IBOutlet weak var planetAiv: UIActivityIndicatorView!
    @IBOutlet weak var tableviewPlanet: UITableView!
    
    var planets = [ResultPlanet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewPlanet.register(UINib.init(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
        
        tableviewPlanet.delegate = self
        tableviewPlanet.dataSource = self
        
        fetchPlanetData()
    }
    
    fileprivate func fetchPlanetData(){
        Service.shared.fetchPlanet(page: 1) { planetData, err in
            if let err {
                print("Error while fetching data at PlanetVc",err)
                return
            }
            if let planetData{
                self.planets = []
                self.planets = planetData.results
            }
        }
        DispatchQueue.main.async {
            self.tableviewPlanet.reloadData()
            self.planetAiv.stopAnimating()
        }
    }
    
    fileprivate var isPagination = false
    fileprivate var isDonePagination = false
    fileprivate var page = 1
    
    fileprivate var timer: Timer?
    
}

extension PlanetsVC: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.isPagination = false
            planetWarningLabel.text = ""
            fetchPlanetData()
        }else {
            planets = []
            tableviewPlanet.reloadData()
            planetWarningLabel.text = ""
            planetAiv.startAnimating()
            
            timer?.invalidate()
            
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block:  { _ in
                
                Service.shared.searchPlanetsByName(searchTerm: searchText) { planetDatas, errData in
                    if let errData {
                        print("Error while fetching data at planets", errData)
                        return
                    }
                    if let planetDatas {
                        self.planets = []
                        self.planets = planetDatas.results
                        self.isPagination = true
                        
                        DispatchQueue.main.async {
                            self.tableviewPlanet.reloadData()
                            self.planetAiv.stopAnimating()
                        }
                    }
                    else {
                        Service.shared.searchPlanetsByType(searchTerm: searchText) { planetsName, errName in
                            if let errName {
                                print("Error while fetching data at PlanetBynane",errName)
                                return
                            }else if let planetsName {
                                self.planets = []
                                self.planets = planetsName.results
                                
                                DispatchQueue.main.async {
                                    self.tableviewPlanet.reloadData()
                                    self.planetAiv.stopAnimating()
                                }
                            }else {
                                DispatchQueue.main.async {
                                    self.planetAiv.stopAnimating()
                                    self.planetWarningLabel.text = "Herhangi bir sonuç bulunamadı.. \n \n Şunları deneyin: 'Earth, 137'  "
                                    self.planetWarningLabel.isHidden = false
                                }
                              
                            }
                        }
                    }
                    
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewPlanet.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeCellController
        let planet = planets[indexPath.item]
        
        var dimonsion : String {
            if planet.dimension == "unknown" {
                return ""
            }else{
                return " - \(planet.dimension)"
            }
        }
        cell.episodeName.text = planet.name
        cell.episodeAirDate.text = planet.created
        cell.episodeSe.text = "\(planet.type)\(dimonsion)"
        
        if indexPath.item == planets.count - 1 && !isPagination && page < 8{
            cell.episodeCellStackView.isHidden = true
            cell.activityIndicator.startAnimating()
            
            print("fetching more data for planets")
            
            isPagination = true
            
            page += 1
            
            Service.shared.fetchPlanet(page: page) { planetData, err in
                if let err {
                    print("Error while fetching more data at planet's pagination",err)
                }
                
                if planetData?.results.count == 0 {
                    self.isPagination = true
                }
                
                sleep(2)
                
                if let planetData {
                    self.planets += planetData.results
                    
                    DispatchQueue.main.async {
                        cell.episodeCellStackView.isHidden = false
                        cell.activityIndicator.stopAnimating()
                        self.tableviewPlanet.reloadData()
                    }
                }
                self.isPagination = false
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 8.5
    }
    
}
