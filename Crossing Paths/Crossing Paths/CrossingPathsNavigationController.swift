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

class CrossingPathsNavigationController: UINavigationController,
SplashViewControllerDelegate, ChooseStartingCharacterViewControllerDelegate, EnterRoomNameViewControllerDelegate, ThanksViewControllerDelegate, VoteViewControllerDelegate {

    

    

    var roomReference: DatabaseReference?

    var userId: String? {
        get { return Auth.auth().currentUser?.uid }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.viewControllers.first as? SplashViewController)?.delegate = self
    }
    
    func goToEnterRoomView() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "enterRoom") as? EnterRoomNameViewController else { return }
        vc.delegate = self
        self.setViewControllers([vc], animated: true)
    }
    
    // MARK: - SplashViewControllerDelegate
    
    func splash(vc: SplashViewController, timerExpired: Any?) {
        self.goToEnterRoomView()
    }
    
    
    // MARK: - EnterRoomNameViewControllerDelegate Implementation
    
    fileprivate func openCredits() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "thanks") as! ThanksViewController
        vc.delegate = self
        self.setViewControllers([vc], animated: true)
    }
    
    func enterRoomName(vc: EnterRoomNameViewController, enteredRoomName: String) {
        
        let ref: DatabaseReference = Database.database().reference()
        
        let roomChild = ref.child(enteredRoomName)
        self.roomReference = roomChild
        
        var handle: UInt = 0
        
        handle = roomChild.child("status").observe(.value, with: { (snapshot) in

            guard let status = (snapshot.value as? String).flatMap({ RoomStatus(rawValue: $0) }) else {
                
                // We want to stop listening if it's null
                ref.removeObserver(withHandle: handle)
                vc.displayError(text: "No room exists with that name")
                return
                
            }
            
            switch status {
            case .waitingToStart:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "waiting")
                self.setViewControllers([vc!], animated: true)
                
            case .pickingCharacter:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "pickCharacter") as! ChooseStartingCharacterViewController
                vc.delegate = self
                self.setViewControllers([vc], animated: true)
                
            case .playing:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "vote")
                (vc as? VoteLeftRightViewController)?.delegate = self
                (vc as? TiltVoteViewController)?.delegate = self
                self.setViewControllers([vc!], animated: true)
                
            case .finished:
                self.openCredits()
                break
                
            }
            
        }) { (error) in
            self.goToEnterRoomView()
        }
        
    }
    
    func enterRoomName(vc: EnterRoomNameViewController, pressedFacebook: Any?) {
        guard let fbUrl = URL(string: "https://www.facebook.com/crossingpathsfilm/") else { return }
        if UIApplication.shared.canOpenURL(fbUrl) {
            UIApplication.shared.open(fbUrl, options: [:], completionHandler: nil)
        }
    }
    
    func enterRoomName(vc: EnterRoomNameViewController, pressedCredits: Any?) {
        self.openCredits()
    }
    

    // MARK: - ChooseStartingCharacterViewControllerDelegate
    
    func chooseStartingCharacter(vc: ChooseStartingCharacterViewController, selectedCharacter: CharacterData?) {
        
        // Vote for that character to start
        
        guard let id = self.userId else {
            return
        }
        
        roomReference?.child("characterVotes").child(id).setValue(selectedCharacter?.name ?? "None")
    }
    
    // MARK: - ThanksViewControllerDelegate
    
    func thanks(vc: ThanksViewController, pressedThanks: Any?) {
        self.goToEnterRoomView()
    }
    
    // MARK: - VoteViewControllerDelegate
    
    func vote(vc: UIViewController, voted: VoteStatus) {
        guard let id = userId else { return }
        
        switch voted {
        case .left: roomReference?.child("leftRightVotes").child(id).setValue("left")
        case .right: roomReference?.child("leftRightVotes").child(id).setValue("right")
        case .none: roomReference?.child("leftRightVotes").child(id).setValue("none")
        }
    }
    

}




