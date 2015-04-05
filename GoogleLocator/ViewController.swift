//
//  ViewController.swift
//  GoogleLocator
//
//  Created by Gayan on 2015-04-05.
//  Copyright (c) 2015 Gayan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    @IBOutlet var cityLbl: UILabel!
    @IBOutlet var postalCodeLbl: UILabel!
    @IBOutlet var provinceLbl: UILabel!
    @IBOutlet var countryLbl: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        cityLbl.text = ""
        postalCodeLbl.text = ""
        provinceLbl.text = ""
        countryLbl.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
            
            if (error != nil) {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Error with the data.")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
        cityLbl.text = placemark.locality
        postalCodeLbl.text = placemark.postalCode
        provinceLbl.text = placemark.administrativeArea
        countryLbl.text = placemark.country
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error on did Fail with Error : " + error.localizedDescription)
    }

}

