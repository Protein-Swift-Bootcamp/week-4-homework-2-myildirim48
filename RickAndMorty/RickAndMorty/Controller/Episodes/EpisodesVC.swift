//
//  EpisodesVC.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class EpisodesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
                self.episodes = episodesData.results
                
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    fileprivate var isPagination = false
    fileprivate var isDonePagination = false
    fileprivate var page = 1
    
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
