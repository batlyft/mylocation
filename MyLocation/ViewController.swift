//
//  ViewController.swift
//  MyLocation
//
//  Created by Bat Computer on 10/15/15.
//  Copyright © 2015 HardSoft. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        print(locations)
        
        let userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if error != nil {
                print(error)
            } else {
                let p = placemarks?.first
                let subThoroughfare = p?.subThoroughfare != nil ? p?.subThoroughfare : ""
                let thoroughfare = p?.thoroughfare != nil ? p?.thoroughfare : ""
                let country = p?.country != nil ? p?.country : ""
                let postal = p?.postalCode != nil ? p?.postalCode : ""
                let city = p?.locality != nil ? p?.locality : ""
                let state = p?.administrativeArea != nil ? p?.administrativeArea : ""
                
                self.addressLabel.text = "\(subThoroughfare!) \(thoroughfare!) \n \(city!), \(state!) \n \(country!) \(postal!)"
            }
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

