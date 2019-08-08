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

class MapMenuViewController: UIViewController {
    
    let dimEffectView = UIView()
    
    var delegate: HandleMenuDismissProtocol?

    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wholeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
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
        UIView.animate(withDuration: 0.75) {
            self.rightConstraint.constant = screenWidth / 4
            self.view.layoutIfNeeded()
        }
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
