//
//  ViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 10/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLeftButton(_ sender: Any) {
        
        print("hello")
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
//        self.ref.child("users").child(user.uid).setValue(["username": username])
        
        ref.child("votes").child("left").setValue("Shazaam")
    }
    
    @IBAction func onRightButton(_ sender: Any) {
        print("yo")
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
    }
    
}

