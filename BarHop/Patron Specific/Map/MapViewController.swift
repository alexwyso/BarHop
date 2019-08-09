//
//  MapViewController.swift
//  BarHop
//
//  Created by Wysoczanski, Alex on 8/6/19.
//  Copyright © 2019 Wysoczanski, Alex. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, HandleMenuDismissProtocol, HandleLocationDismissProtocol, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let dimEffectView = UIView()
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "HammersmithOne-Regular", size: 28)!]
        let img = UIImage(named: "Screen-Shot-2014-12-02-at-11.14.42.png")
        setUpProfileButton(img: img!)
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            map.delegate = self
            map.showsUserLocation = true
            map.isScrollEnabled = true
            map.isZoomEnabled = true
        }
        
        dimEffectView.backgroundColor = .black
        dimEffectView.frame = view.bounds
        dimEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimEffectView.alpha = 0
        view.addSubview(dimEffectView)
    }
    
    func setUpProfileButton(img: UIImage) {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(button.frame.size, false, img.scale)
        let rect  = CGRect(x: 0, y: 0, width: button.frame.size.width, height: button.frame.size.height)
        UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).addClip()
        img.draw(in: rect)
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
        
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MapMenu")
        
        UIView.animate(withDuration: 0.5, animations: {
            self.dimEffectView.alpha = 0.6
        })
        
        nextViewController.modalPresentationStyle = .overCurrentContext
        if let nextViewController = nextViewController as? MapMenuViewController {
            nextViewController.delegate = self
        }
        present(nextViewController, animated: false, completion: nil)
    }
    
    func menuDismissed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimEffectView.alpha = 0
        })
    }
    
    func locationDismissed(done: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimEffectView.alpha = 0
        })
        
        if (done) {
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
            let backItem = UIBarButtonItem()
            backItem.title = "Map"
            navigationItem.backBarButtonItem = backItem
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025))
            map.setRegion(region, animated: false)
            
            let bar = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.0002, longitude: location.coordinate.longitude + 0.0002)
            let annotation = MKPointAnnotation()
            annotation.coordinate = bar
            annotation.title = "Smokey Joe's"
            map.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MapBottom")
        
        nextViewController.modalPresentationStyle = .overCurrentContext
        if let nextViewController = nextViewController as? MapBottomDetailsViewController {
            nextViewController.delegate = self
        }
        present(nextViewController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = false
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
