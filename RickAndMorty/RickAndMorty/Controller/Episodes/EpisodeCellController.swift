//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class EpisodeCellController: UITableViewCell {
    
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeSe: UILabel!
    @IBOutlet weak var episodeAirDate: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var episodeCellStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.stopAnimating()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
