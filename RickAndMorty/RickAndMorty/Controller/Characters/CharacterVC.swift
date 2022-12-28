//
//  ViewController.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 27.12.2022.
//

import UIKit

class CharacterVC: UIViewController {

    @IBOutlet weak var charTableView: UITableView!
    
    var characters = [CharResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charTableView.register(UINib.init(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "charCellid")
        
        charTableView.delegate = self
        charTableView.dataSource = self
        
        fetchCharData()
    }
    fileprivate func fetchCharData() {
        Service.shared.fetchCharacter(page: 1) { charData, err in
            if let err {
                print("Error while fetching data at CharacterVC",err)
            }
            if let charData {
                self.characters = charData.results
            }
        }
    }
    fileprivate var isPagination = false
    fileprivate var isDonePagination = false
    fileprivate var page = 1
}
extension CharacterVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charTableView.dequeueReusableCell(withIdentifier: "charCellid", for: indexPath) as! CharactersCellController
        let char = characters[indexPath.item]
        cell.charImageView.imageFrom(url: URL(string: char.image)!)
        
        cell.charNamelabel.text = char.name
        
        switch char.gender.rawValue {
        case "unknown":
            cell.genderLabel.text = ""
        default:
            cell.genderLabel.text = char.gender.rawValue
        }
        
        
        switch char.status.rawValue {
        case "Alive":
            cell.statusLabel.textColor = UIColor(red: 0.78, green: 0.84, blue: 0.49, alpha: 1.00)
            cell.statusLabel.text = char.status.rawValue

        case "Dead":
            cell.statusLabel.textColor = UIColor(red: 0.84, green: 0.49, blue: 0.49, alpha: 1.00)
            cell.statusLabel.text = char.status.rawValue

        case "unknown":
            cell.statusLabel.text = "Where are you?"
            cell.statusLabel.textColor = .black
        default:
            cell.statusLabel.text = "hi"
        }

        
        cell.speciesLabel.text = char.species
        
        switch char.origin.name {
        case "unknown":
            cell.originLabel.text = ""
        default:
            cell.originLabel.text = char.origin.name
        }
        
        if indexPath.item == characters.count - 1  && !isPagination && page < 43{
            
            //Hiding stack view CharacterCell,Starting animation
            cell.charStackView.isHidden = true
            cell.aivChar.startAnimating()
            
            print("Fetching more data")
            
     
            isPagination = true

                page += 1
                
                
                Service.shared.fetchCharacter(page: page) { charData, err in
                    if let err {
                        print("Error at pagination",err)
                    }
                    
                    if charData?.results.count == 0 {
                        self.isDonePagination = true
                    }
                    
                    sleep(2)
                    if let charData {
                        self.characters += charData.results
                        
                        DispatchQueue.main.async {
                            cell.charStackView.isHidden = false
                            cell.aivChar.stopAnimating()
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

