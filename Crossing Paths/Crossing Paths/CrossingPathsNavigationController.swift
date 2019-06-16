//
//  CrossingPathsNavigationController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 16/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CrossingPathsNavigationController: UINavigationController, ChooseStartingCharacterViewControllerDelegate, EnterRoomNameViewControllerDelegate {

    var roomReference: DatabaseReference?

    var userId: String? {
        get { return Auth.auth().currentUser?.uid }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        (self.viewControllers.first as? EnterRoomNameViewController)?.delegate = self
        
    }
    
    
    // MARK: - EnterRoomNameViewControllerDelegate Implementation
    
    func enterRoomName(vc: EnterRoomNameViewController, enteredRoomName: String) {
        
        let ref: DatabaseReference = Database.database().reference()
        
        let roomChild = ref.child(enteredRoomName)
        self.roomReference = roomChild
        
        roomChild.observeSingleEvent(of: .value, with: { (snapshot) in
        
            // Code with the data for the room in here
        
            guard let status = (snapshot.childSnapshot(forPath: "status").value as? String).flatMap({ RoomStatus(rawValue: $0) }) else {
                return
            }
        
        
            switch status {
            case .waitingToStart:
                break
        
            case .pickingCharacter:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "pickCharacter") as! ChooseStartingCharacterViewController
                vc.delegate = self
                self.pushViewController(vc, animated: true)
        
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
    

    // MARK: - ChooseStartingCharacterViewControllerDelegate
    
    func chooseStartingCharacter(vc: ChooseStartingCharacterViewController, selectedCharacter: CharacterData) {
        
        // Vote for that character to start
        
        guard let id = self.userId else {
            return
        }
        
        roomReference?.child("characterVotes").child(id).setValue(selectedCharacter.name)

    }
    


}




