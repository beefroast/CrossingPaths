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
    @IBOutlet weak var tickContainer: UIView!
    
}


protocol ChooseStartingCharacterViewControllerDelegate: AnyObject {
    func chooseStartingCharacter(vc: ChooseStartingCharacterViewController, selectedCharacter: CharacterData?)
}


class ChooseStartingCharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: ChooseStartingCharacterViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    let characters: [CharacterData] = CharacterData.orderedCharacters
    
    var selectedIndex: Int? = nil {
        didSet {
            
            guard selectedIndex != oldValue else {
                return
            }
            
            let selectedCharacter = selectedIndex.map({ self.characters[$0] })
            self.delegate?.chooseStartingCharacter(vc: self, selectedCharacter: selectedCharacter)
            
            let reloadedIndexPaths: [IndexPath?] = [
                oldValue.map({ return IndexPath.init(row: $0, section: 0) }),
                selectedIndex.map({ return IndexPath.init(row: $0, section: 0) })
            ]
            
            self.tableView.reloadRows(
                at: reloadedIndexPaths.compactMap({ return $0 }),
                with: UITableView.RowAnimation.none
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        
        self.delegate?.chooseStartingCharacter(vc: self, selectedCharacter: nil)
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
        cell.selectionStyle = .none
        
        cell.tickContainer.isHidden = (self.selectedIndex ?? -1 != indexPath.row)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cpMauve
            cell.tickContainer.backgroundColor = UIColor.cpMauve
        } else {
            cell.backgroundColor = UIColor.cpYellow
            cell.tickContainer.backgroundColor = UIColor.cpYellow
        }
        
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.selectedIndex == indexPath.row {
            self.selectedIndex = nil
        } else {
            self.selectedIndex = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}
