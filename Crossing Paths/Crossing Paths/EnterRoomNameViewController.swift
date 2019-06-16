//
//  EnterRoomNameViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 15/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EnterRoomNameViewController: UIViewController {

    @IBOutlet weak var roomNameTextField: UITextField!
    
    
    @IBOutlet weak var roomNameButton: UIButton!
    
    
    @IBAction func onButtonPressed(_ sender: Any) {
        
        guard let input = roomNameTextField.text else {
            return
        }
        
        let ref: DatabaseReference = Database.database().reference()
        
        let roomChild = ref.child(input)
        
        roomChild.observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Code with the data for the room in here
            
            let allowsUsersToVoteOnFirstCharacter = "allowsUsersToVoteOnFirstCharacter"
            
            guard snapshot.hasChild(allowsUsersToVoteOnFirstCharacter) else {
                // TODO: Tell the user the room doesn't exist and to try again
                return
            }
            
            guard let allowsVoteOnInitialCharacter = snapshot.childSnapshot(forPath: allowsUsersToVoteOnFirstCharacter).value as? Bool else {
                return
            }
            
            guard let status = (snapshot.childSnapshot(forPath: "status").value as? String).flatMap({ RoomStatus(rawValue: $0) }) else {
                return
            }
            
            
            switch status {
            case .waitingToStart:
                break
                
            case .pickingCharacter:
                self.performSegue(withIdentifier: "pickCharacter", sender: nil)
                
            case .playing:
                self.performSegue(withIdentifier: "showVotes", sender: roomChild)
        
            case .finished:
                print("Film has finished!")
                break
                
            }
            

        }) { (error) in
            // Code called/run if it didn't work and we got an error.
            
            print(error)
            
        }
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.votesRef = sender as? DatabaseReference
        }
    }
    
    

    


}
