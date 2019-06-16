//
//  ChooseStartingCharacterViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 15/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit

class ChooseStartingCharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
}

class ChooseStartingCharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    class CharacterData {
        
        
        let name: String
        let image: UIImage
        
        init(name: String, image: UIImage) {
            self.name = name
            self.image = image
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    let characters: [CharacterData] = [
        CharacterData(name: "Jeff", image: UIImage(named: "cat")!),
        CharacterData(name: "Kerber", image: UIImage(named: "bun")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    
    
    
    
    // MARK: - TableViewDelegate/DataSource Implementation
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! ChooseStartingCharacterTableViewCell
        
        let characterData = characters[indexPath.row]
        
        cell.characterNameLabel.text = characterData.name
        cell.characterImageView.image = characterData.image
        
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let characterData = characters[indexPath.row]

        
        print("You selected \(characterData.name)")
        
        self.performSegue(withIdentifier: "showVotes", sender: nil)
        
    }
    
    

}
