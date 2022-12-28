//
//  EpisodesVC.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class EpisodesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .systemGray4
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var epsiodes = [ResultEpisode]() //Episode data variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //XİB cell registration
        episodeTableView.register(UINib.init(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        
        fetchEpisodeData()//Fetching data
    }
    
    func fetchEpisodeData(){
        Service.shared.fetchEpisodes { episodesData , err in
            if let err = err {
                print("Error while fetching data at EpisodeVC",err)
                return
            }
            self.epsiodes = episodesData?.results ?? []
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return epsiodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell",for: indexPath) as! EpisodeCell
        let episode = epsiodes[indexPath.item]
        cell.episodeName.text = episode.name
        cell.episodeAirDate.text = episode.airDate
        cell.episodeSe.text = episode.episode
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }

}
