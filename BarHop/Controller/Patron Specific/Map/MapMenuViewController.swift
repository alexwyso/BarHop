//
//  MapMenuViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

protocol HandleMenuDismissProtocol {
    func menuDismissed()
}

class MapMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dimEffectView = UIView()
    
    var delegate: HandleMenuDismissProtocol?

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    
    let labels = ["Map", "Transaction History", "Venmo Account Settings", "Edit Personal Information", "Log Out"]
    let pics = ["Pin-512.png", "iconfinder_Dollar_1737376.png", "iconfinder_venmo_4691351.png", "iconfinder_new-24_103173.png", "iconfinder_log-out_3324993.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        table.delegate = self
        table.dataSource = self
        
        table.isScrollEnabled = false
        
        table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        widthConstraints.constant = screenWidth * 0.75
        
        rightConstraint.constant = screenWidth
    
        dimEffectView.backgroundColor = .clear
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 1
        view.addSubview(dimEffectView)
        view.sendSubviewToBack(dimEffectView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        UIView.animate(withDuration: 0.5) {
            self.widthConstraints.constant = screenWidth * 0.75
            self.rightConstraint.constant = screenWidth / 4
            self.view.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ButtonCell") as! MapButtonsTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.optionLabel.text = labels[indexPath.row]
        cell.optionImage.image = UIImage(named: pics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view == dimEffectView {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            UIView.animate(withDuration: 0.5) {
                self.rightConstraint.constant = screenWidth
                self.view.layoutIfNeeded()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.51) {
                self.dismiss(animated: false, completion: nil)
                self.delegate?.menuDismissed()
            }
            
        }
    }
}
