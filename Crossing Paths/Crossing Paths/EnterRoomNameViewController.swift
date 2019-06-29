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
    func enterRoomName(vc: EnterRoomNameViewController, pressedFacebook: Any?)
    func enterRoomName(vc: EnterRoomNameViewController, pressedCredits: Any?)
}


class EnterRoomNameViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: EnterRoomNameViewControllerDelegate? = nil
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomNameButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomNameTextField.delegate = self
        self.facebookButton.underline()
        self.creditsButton.underline()
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
        
        self.activityIndicator.startAnimating()
        self.roomNameButton.isHidden = true
        self.delegate?.enterRoomName(vc: self, enteredRoomName: input)
    }
    
    @IBAction func onFacebookPressed(_ sender: Any) {
        self.delegate?.enterRoomName(vc: self, pressedFacebook: sender)
    }
    
    @IBAction func onViewCreditsPressed(_ sender: Any) {
        self.delegate?.enterRoomName(vc: self, pressedCredits: sender)
    }
    
    func displayError(text: String) {
        // TODO: Display the error here
        self.activityIndicator.stopAnimating()
        self.roomNameButton.isHidden = false
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: text])
        (roomNameTextField as? MFTextField)?.setError(error, animated: true)
    }
    
    // UITextFieldDelegate Implementation
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (roomNameTextField as? MFTextField)?.setError(nil, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let typeCasteToStringFirst = textField.text as? NSString else { return false }
        let newString = typeCasteToStringFirst.replacingCharacters(in: range, with: string)
        guard let sString = newString as? String else { return false }
        return sString.isAlphanumeric() && sString.count <= 10
    }

}

extension String {
    
    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
    
    func isAlphanumeric(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlphanumeric()
        }
    }
    
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
