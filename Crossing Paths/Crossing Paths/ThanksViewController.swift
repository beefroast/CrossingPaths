//
//  ThanksViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 20/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit

protocol ThanksViewControllerDelegate: AnyObject {
    func thanks(vc: ThanksViewController, pressedThanks: Any?)
}

class ThanksViewController: UIViewController {

    weak var delegate: ThanksViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onDonePressed(_ sender: Any) {
        self.delegate?.thanks(vc: self, pressedThanks: sender)
    }
    

}
