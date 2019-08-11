//
//  ReviewCartViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/9/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

class ReviewCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func placeOrderPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Confirmation", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "Waiting") as! WaitingViewController
        present(nextViewController, animated: true)
    }
}
