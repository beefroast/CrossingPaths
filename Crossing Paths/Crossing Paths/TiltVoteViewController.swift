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

    
    var motionManager: CMMotionManager!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        motionManager = CMMotionManager()

        guard let opQueue = OperationQueue.current else {
            fatalError("There's no op queue!")
        }
        
        motionManager.startAccelerometerUpdates(to: opQueue) { (data, error) in
            print(data?.acceleration)
        }
        
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
