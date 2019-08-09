//
//  MenuPopoverViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

protocol HandlePriceEntryDismissProtocol {
    func priceEntryDismissed()
}

class MenuPopoverViewController: UIViewController {

    var delegate: HandlePriceEntryDismissProtocol?
    
    let dimEffectView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimEffectView.backgroundColor = .clear
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 1
        view.addSubview(dimEffectView)
        view.sendSubviewToBack(dimEffectView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view == dimEffectView {
            self.dismiss(animated: false, completion: nil)
            self.delegate?.priceEntryDismissed()
        }
    }

}
