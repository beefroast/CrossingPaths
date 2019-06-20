//
//  ViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 10/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


enum VoteStatus {
    case left
    case right
    case none
}

protocol VoteViewControllerDelegate: AnyObject {
    func vote(vc: UIViewController, voted: VoteStatus)
}

class VoteLeftRightViewController: UIViewController {

    weak var delegate: VoteViewControllerDelegate? = nil
    
    @IBAction func onLeftButton(_ sender: Any) {
        self.delegate?.vote(vc: self, voted: VoteStatus.left)
    }
    
    @IBAction func onRightButton(_ sender: Any) {
        self.delegate?.vote(vc: self, voted: VoteStatus.right)
    }
    
}

