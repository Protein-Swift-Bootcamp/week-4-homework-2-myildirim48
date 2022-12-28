//
//  CharactersCellController.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 28.12.2022.
//

import UIKit

class CharactersCellController: UITableViewCell {

    
    @IBOutlet weak var charStackView: UIStackView!
    @IBOutlet weak var aivChar: UIActivityIndicatorView!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var charNamelabel: UILabel!
    @IBOutlet weak var charImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        charImageView.layer.borderWidth = 1
        charImageView.layer.borderColor = .init(gray: 10, alpha: 1)
        
        charImageView.layer.cornerRadius = 15
        charImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
