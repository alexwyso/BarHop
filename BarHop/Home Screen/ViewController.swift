//
//  ViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signInStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInStackView.alpha = 0
        signInStackView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5,  delay: 1, options: .curveEaseOut, animations: {
            self.signInStackView.isHidden = false
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 1.5, options: .curveEaseOut, animations: {
            self.signInStackView.alpha = 1
        }, completion: nil)
    }

    @IBAction func loginPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MapNavigationController") as! UINavigationController
        nextViewController.modalPresentationStyle = .overCurrentContext
        present(nextViewController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

