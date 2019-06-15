//
//  EnterRoomNameViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 15/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit

class EnterRoomNameViewController: UIViewController {

    @IBOutlet weak var roomNameTextField: UITextField!
    
    
    @IBOutlet weak var roomNameButton: UIButton!
    
    
    @IBAction func onButtonPressed(_ sender: Any) {
        
        let input = roomNameTextField.text
    
        print(input)
    
        self.performSegue(withIdentifier: "pickCharacter", sender: nil)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
