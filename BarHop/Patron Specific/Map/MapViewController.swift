//
//  MapViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "HammersmithOne-Regular", size: 28)!]
        setUpProfileButton()
    }
    
    func setUpProfileButton() {
        let img = UIImage(named: "Screen-Shot-2014-12-02-at-11.14.42.png")
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(button.frame.size, false, img!.scale)
        let rect  = CGRect(x: 0, y: 0, width: button.frame.size.width, height: button.frame.size.height)
        UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).addClip()
        img!.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let color = UIColor(patternImage: newImage!)
        button.backgroundColor = color
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.leftBarButtonItem = barButton
        button.addTarget(self, action: #selector(profileClicked), for: .touchUpInside)
    }
    
    @objc func profileClicked() {
        print("here")
    }

}
