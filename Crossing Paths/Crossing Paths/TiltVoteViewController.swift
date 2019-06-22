//
//  TiltVoteViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 20/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit
import CoreMotion

class TiltVoteViewController: UIViewController {

    weak var delegate: VoteViewControllerDelegate? = nil
    
    var motionManager: CMMotionManager!
    
    var voteStatus: VoteStatus = .none {
        didSet { self.delegate?.vote(vc: self, voted: self.voteStatus) }
    }
    

    @IBOutlet weak var viewHoldPhoneUp: UIView!
    @IBOutlet weak var imgViewLeft: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        motionManager = CMMotionManager()

        guard let opQueue = OperationQueue.current else {
            fatalError("There's no op queue!")
        }
        
        motionManager.startDeviceMotionUpdates(to: opQueue) { (motion, error) in
            
            guard let gravity = motion?.gravity else { return }
            
            // Get the angles between the critical points
            
            // Get the angle beteween gravity and the 'voting right position
            
            
            guard gravity.z <= 0.0 && gravity.z >= -sqrt(0.5) else {
                self.imgViewLeft.isHidden = true
                self.viewHoldPhoneUp.isHidden = false
                self.voteStatus = .none
                return
            }
            
            self.viewHoldPhoneUp.isHidden = true
            
            // So now ignore the Z component, and normalize the X,Y vector
            let uX = gravity.x
            let uY = gravity.y
            
            let length = sqrt(uX*uX + uY*uY)
            let nX = uX/length
            let nY = uY/length
            
            
            // Get the angle between (nX, nY) and straight down
            
            let cosineAngle = nY * -1.0
            let radians = acos(cosineAngle)
            
            
            guard radians > 0.3 else {
                self.imgViewLeft.isHidden = true
                self.voteStatus = .none
                return
            }
            
            self.imgViewLeft.isHidden = false
            
            if nX < 0.0 {
                self.imgViewLeft.image = UIImage(named: "Left")
                self.imgViewLeft.layer.transform = CATransform3DMakeRotation(CGFloat(radians) * 0.8, 0, 0, 1.0)
                self.voteStatus = .left
            } else {
                self.imgViewLeft.image = UIImage(named: "Right")
                self.imgViewLeft.layer.transform = CATransform3DMakeRotation(CGFloat(-radians) * 0.8, 0, 0, 1.0)
                self.voteStatus = .right
            }
        }
        
    }
    
    func angleInRadiansBetween(gravity: CMAcceleration, x: Double, y: Double, z: Double) -> Double {
        let cosineTheta = gravity.x * x + gravity.y * y + gravity.z * z
        return acos(cosineTheta)
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
