//
//  EnterRoomNameViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 15/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MaterialTextField

protocol EnterRoomNameViewControllerDelegate: AnyObject {
    func enterRoomName(vc: EnterRoomNameViewController, enteredRoomName: String)
}


class EnterRoomNameViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: EnterRoomNameViewControllerDelegate? = nil
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomNameTextField.delegate = self
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        
        guard let input = roomNameTextField.text else {
            return
        }
        
        self.view.endEditing(true)
        
        guard input.count > 0 else {
            self.displayError(text: "Please enter a room name")
            return
        }
        
        self.delegate?.enterRoomName(vc: self, enteredRoomName: input)
    }
    
    func displayError(text: String) {
        // TODO: Display the error here
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: text])
        (roomNameTextField as? MFTextField)?.setError(error, animated: true)
    }
    
    // UITextFieldDelegate Implementation
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (roomNameTextField as? MFTextField)?.setError(nil, animated: true)
    }
    

}
