//
//  EnterRoomNameViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 15/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase


protocol EnterRoomNameViewControllerDelegate: AnyObject {
    
    func enterRoomName(vc: EnterRoomNameViewController, enteredRoomName: String)
    
}


class EnterRoomNameViewController: UIViewController {

    weak var delegate: EnterRoomNameViewControllerDelegate? = nil
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomNameButton: UIButton!
    
    @IBAction func onButtonPressed(_ sender: Any) {
        
        guard let input = roomNameTextField.text else {
            return
        }
        
        self.delegate?.enterRoomName(vc: self, enteredRoomName: input)
    }
    
    func displayError(text: String) {
        // TODO: Display the error here
        print(text)
    }

}
