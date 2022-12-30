//
//  EpisodesVC.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class EpisodesVC: UIViewController{
    
    
    @IBOutlet weak var warningText: UILabel!
    @IBOutlet weak var episodeAiv: UIActivityIndicatorView!
    @IBOutlet weak var searchBarEpisode: UISearchBar!
    @IBOutlet weak var episodeTableView: UITableView!
    
    
    var episodes = [ResultEpisode]() //Episode data variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //XİB cell registration
        episodeTableView.register(UINib.init(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        
        
        fetchEpisodeData()//Fetching data
    }
    
    func fetchEpisodeData(){
        Service.shared.fetchEpisodes(page: 1) { episodesData , err in
            if let err = err {
                print("Error while fetching data at EpisodeVC",err)
                return
            }
            if let episodesData {
                self.episodes = []
                self.episodes = episodesData.results
                
            }
        }
        DispatchQueue.main.async {
            self.episodeTableView.reloadData()
        }
    }
    
    fileprivate var isPagination = false
    fileprivate var isDonePagination = false
    fileprivate var page = 1
    
    fileprivate var timer: Timer?
    
}
extension EpisodesVC: UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.isPagination = false
            warningText.text = ""
            fetchEpisodeData()
        }else {
            
            self.episodes = []
            self.episodeTableView.reloadData()
            episodeAiv.startAnimating()
            
            
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                    
                    if searchText.isNumber{
                        if Int(searchText)! < 12{
                                Service.shared.searchEpisodesNum(searchTerm: searchText) { episoData, err in
                            if let err {
                                print("Error while searching episodes",err)
                            }
                            
                            if let episoData {
                                self.episodes = []
                                
                                self.isPagination = true
                                self.episodes = episoData.results
                                
                                DispatchQueue.main.async { [self] in
                                    self.episodeTableView.reloadData()
                                    self.episodeAiv.stopAnimating()
                                }
                            }
                        }
                        }else {
                            DispatchQueue.main.async {
                                self.episodeAiv.stopAnimating()
                                self.warningText.text = "En fazla 11. Bölüm var..."
                                self.warningText.isHidden = false
                            }
                        }
                    }else {
                        Service.shared.searchEpisodes(searchTerm: searchText) { episoData, err in
                            if let err {
                                print("Error while searching episodes",err)
                            }
                            
                            if let episoData {
                                self.episodes = []
                                
                                self.isPagination = true
                                self.episodes = episoData.results
                                
                                DispatchQueue.main.async {
                                    self.episodeTableView.reloadData()
                                    self.episodeAiv.stopAnimating()
                                }
                            }else {
                                print("catch")
                                DispatchQueue.main.async {
                                    self.episodeAiv.stopAnimating()
                                    self.warningText.text = "Geçersiz bir arama girdiniz..."
                                    self.warningText.isHidden = false
                                }
                            
                            }
                        }
                    }
                })
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell",for: indexPath) as! EpisodeCellController
        
        let episode = episodes[indexPath.item]
        
        cell.episodeName.text = episode.name
        cell.episodeAirDate.text = episode.airDate
        cell.episodeSe.text = episode.episode
        
        
        if indexPath.item == episodes.count - 1  && !isPagination && page < 3{
            cell.episodeCellStackView.isHidden = true
            
            cell.activityIndicator.startAnimating()
            print("Fetching more data")
            
            
            isPagination = true
            
            page += 1
            
            
            Service.shared.fetchEpisodes(page: page) { episodeDat, err in
                if let err {
                    print("Error at pagination",err)
                }
                
                if episodeDat?.results.count == 0 {
                    self.isDonePagination = true
                }
                
                sleep(2)
                
                if let episodeDat {
                    self.episodes += episodeDat.results
                    
                    DispatchQueue.main.async {
                        cell.episodeCellStackView.isHidden = false
                        cell.activityIndicator.stopAnimating()
                        tableView.reloadData()
                    }
                }
                
                self.isPagination = false
                
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/7
    }
    
}
