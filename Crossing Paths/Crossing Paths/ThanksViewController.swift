//
//  ThanksViewController.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 20/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import UIKit

class ThanksTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

enum CreditData {
    case heading(String)
    case person(String)
    var text: String {
        switch self {
        case .heading(let x): return x
        case .person(let x): return x
        }
    }
}

protocol ThanksViewControllerDelegate: AnyObject {
    func thanks(vc: ThanksViewController, pressedThanks: Any?)
}

class ThanksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    weak var delegate: ThanksViewControllerDelegate? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonDone: UIButton!
    var scrollTimer: Timer? = nil
    
    var creditData: [CreditData] = [
        .heading("WRITTEN AND DIRECTED BY"),
        .person("JJ Winlove"),
        .heading("PRODUCED BY"),
        .person("Emily Bull"),
        .person("Libby Hams"),
        .person("JJ Winlove"),
        .heading("DIRECTOR OF PHOTOGRAPHY"),
        .person("Jonathan Tyler"),
        .heading("PRODUCTION DESIGNER"),
        .person("Brodie Simpson"),
        .heading("EDITOR"),
        .person("Alexandre Guterres"),
        .heading("CASTING DIRECTOR"),
        .person("Antonia Murphy CGA"),
        .heading("SOUND RECORDISTS"),
        .person("Sam Whittaker"),
        .person("Jack Robins"),
        .person("Piotr Wasilewski"),
        .heading("COLOURIST"),
        .person("Sie Kitts"),
        .heading("ORIGINAL MUSIC BY"),
        .person("Alison Cole & Dave Smith for Groove Q"),
        .heading("SOUND DESIGN"),
        .person("Dave Smith for Groove Q"),
        .heading("APP DEVELOPMENT"),
        .person("Kelly McNamara"),
        .person("Benjamin Frost"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: self.view.frame.height, left: 0, bottom: self.view.frame.height, right: 0)
        
        scrollTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true, block: { [weak self] (_) in
            guard let s = self else { return }
            self?.tableView.contentOffset = CGPoint(
                x: 0,
                y: s.tableView.contentOffset.y + 1
            )
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentOffset = CGPoint(x: 0, y: -2000)
    }
    
    @IBAction func onDonePressed(_ sender: Any) {
        self.delegate?.thanks(vc: self, pressedThanks: sender)
    }
    
    
    func cellIdentifierFor(data: CreditData) -> String {
        switch data {
        case .heading(_): return "heading"
        case .person(_): return "person"
        }
    }
    
    // MARK: - UITableViewDataSource/UITableViewDelegate Implementation
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let h = self.tableView.contentSize.height
        let y = self.tableView.contentOffset.y
        
        buttonDone.isHidden = !(h-y <= 600)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.creditData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = creditData[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierFor(data: data), for: indexPath) as? ThanksTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = data.text
        
        return cell
    }
    

}


