//
//  MapBottomDetailsViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

protocol HandleLocationDismissProtocol {
    func locationDismissed(done: Bool)
}

class MapBottomDetailsViewController: UIViewController {
    
    let dimEffectView = UIView()
    
    var delegate: HandleLocationDismissProtocol?
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimEffectView.backgroundColor = .clear
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 1
        view.addSubview(dimEffectView)
        view.sendSubviewToBack(dimEffectView)
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view == dimEffectView {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.locationDismissed(done: false)
        }
    }
    
    @IBAction func xPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.locationDismissed(done: false)
    }
    
    @IBAction func checkInPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.locationDismissed(done: true)
    }
}
