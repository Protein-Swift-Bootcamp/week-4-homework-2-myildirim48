//
//  CharactersDetail.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 2.01.2023.
//

import Foundation
import UIKit
class CharactersDetail: UIViewController {
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var firtseenLocation: UILabel!
    @IBOutlet weak var lastknownLocationlabel: UILabel!
    @IBOutlet weak var statusSpeciesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var charImageView: UIImageView!
    
    var charId : Int = 0
    var charDetails: CharResult! {
        didSet {
            self.charImageView.imageFrom(url: URL(string: charDetails.image)!)
            DispatchQueue.main.async {
                self.nameLabel.text = self.charDetails.name
                self.statusSpeciesLabel.text = " \(self.charDetails.status) - \(self.charDetails.species)"
                self.firtseenLocation.text = self.charDetails.origin.name
                self.lastknownLocationlabel.text = self.charDetails.location.name
                self.navigationItem.title = self.charDetails.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charImageView.layer.cornerRadius = 15
        charImageView.clipsToBounds = true
        
        detailsView.layer.cornerRadius = 15
        detailsView.dropShadow(color: .systemGray2, offSet: CGSize(width: 0, height: 0),radius: 15,scale: true)
        
        getcharDetail()
        
        
    }
    
    
    func getcharDetail(){
        Service.shared.getCharDetails(id: charId) { charDet, err in
            if let err {
                print("Error while fetching data at CharacterDetail",err)
                return
            }
            if let charDet {
                
                self.charDetails = charDet
                
                DispatchQueue.main.async {
                    //                    self.charImageView.imageFrom(url: URL(string: charDet.image)!)
                    //                    self.nameLabel.text = charDet.name
                    //                    self.firtseenLocation.text = charDet.origin.name
                    //                    self.lastknownLocationlabel.text = charDet.location.name
                }
                
            }
        }
    }
    
}
