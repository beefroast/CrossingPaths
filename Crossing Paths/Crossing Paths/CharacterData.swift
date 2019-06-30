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
                CharacterData(name: "Dunc", image: UIImage(named: "CharacterStills_A")!),
                CharacterData(name: "Zoe", image: UIImage(named: "CharacterStills_B")!),
                CharacterData(name: "Ryan", image: UIImage(named: "CharacterStills_C")!),
                CharacterData(name: "Ness", image: UIImage(named: "CharacterStills_D")!),
                CharacterData(name: "Poe", image: UIImage(named: "CharacterStills_E")!),
                CharacterData(name: "Ed", image: UIImage(named: "CharacterStills_F")!),
                CharacterData(name: "Mandy", image: UIImage(named: "CharacterStills_G")!),
                CharacterData(name: "Ruby", image: UIImage(named: "CharacterStills_H")!),
                CharacterData(name: "Bella", image: UIImage(named: "CharacterStills_I")!),
                CharacterData(name: "Lena", image: UIImage(named: "CharacterStills_J")!),
                CharacterData(name: "Ricky", image: UIImage(named: "CharacterStills_K")!),
                CharacterData(name: "Kelsie", image: UIImage(named: "CharacterStills_L")!),
            ]
        }
    }
    
}


