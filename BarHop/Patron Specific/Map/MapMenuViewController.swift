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

    override func viewDidLoad() {
        super.viewDidLoad()

        dimEffectView.backgroundColor = .clear
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 1
        view.addSubview(dimEffectView)
        //view.sendSubviewToBack(dimEffectView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view == dimEffectView {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.menuDismissed()
        }
    }
}
