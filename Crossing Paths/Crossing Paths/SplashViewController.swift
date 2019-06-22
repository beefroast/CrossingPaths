//
//  SplashViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 22/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func splash(vc: SplashViewController, timerExpired: Any?)
}

class SplashViewController: UIViewController {

    weak var delegate: SplashViewControllerDelegate? = nil
    var timer: Timer? =  nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { [weak self] (timer) in
            guard let this = self else { return }
            this.delegate?.splash(vc: this, timerExpired: timer)
        })
    }
}
