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

class VoteLeftRightViewController: UIViewController {

    var votesRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var userId: String? {
        get { return Auth.auth().currentUser?.uid }
    }
    
    
    @IBAction func onLeftButton(_ sender: Any) {
        
        guard let id = userId else { return }
        
        votesRef?.child("leftRightVotes").child(id).setValue("left")
    }
    
    @IBAction func onRightButton(_ sender: Any) {
        
        guard let id = userId else { return }
        
        votesRef?.child("leftRightVotes").child(id).setValue("right")
    }
    
}

