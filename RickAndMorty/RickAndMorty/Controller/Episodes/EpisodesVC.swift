//
//  EpisodesVC.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class EpisodesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var episodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        episodeTableView.register(UINib.init(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell",for: indexPath) as! EpisodeCell
        return cell
    }

}
