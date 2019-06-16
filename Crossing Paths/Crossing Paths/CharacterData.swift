//
//  CharacterData.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 16/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import Foundation
import UIKit


class CharacterData {
    
    
    let name: String
    let image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    
    static var orderedCharacters: [CharacterData] {
        get {
            return [
                CharacterData(name: "Dunc", image: UIImage(named: "cat")!),
                CharacterData(name: "Zoe", image: UIImage(named: "cat")!),
                CharacterData(name: "Ryan", image: UIImage(named: "cat")!),
                CharacterData(name: "Ness", image: UIImage(named: "cat")!),
                CharacterData(name: "Poe", image: UIImage(named: "cat")!),
                CharacterData(name: "Ed", image: UIImage(named: "cat")!),
                CharacterData(name: "Mandy", image: UIImage(named: "cat")!),
                CharacterData(name: "Ruby", image: UIImage(named: "cat")!),
                CharacterData(name: "Bella", image: UIImage(named: "cat")!),
                CharacterData(name: "Lena", image: UIImage(named: "cat")!),
                CharacterData(name: "Ricky", image: UIImage(named: "cat")!),
                CharacterData(name: "Kelsie", image: UIImage(named: "cat")!),
            ]
        }
    }
    
}

