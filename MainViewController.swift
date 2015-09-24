//
//  MainViewController.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 9/23/15.
//  Copyright (c) 2015 Mary K Paquette. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

let locationManager = CLLocationManager()
let LocationPlaceMark = CLPlacemark()
var placeMarksString = ""
var placeMarksInfoLabel = UILabel()

class MainViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var zipcodeTF: UITextField! = nil

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBAction func showPlacemarks(sender: AnyObject) {
        //13 open (i) pop up panel
            if (placeMarksInfoLabel.hidden) {
                placeMarksInfoLabel.text = placeMarksString
                placeMarksInfoLabel.hidden = false
            }
            else {
                placeMarksInfoLabel.hidden = true
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      mapView.delegate = self
      zipcodeTF.delegate = self
        
        //5 Location is set here
        let eiffelTowerLocation = CLLocationCoordinate2D(latitude:48.8582 , longitude:2.2945)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let mapRegion = MKCoordinateRegion(center: eiffelTowerLocation, span: mapSpan)
        mapView.setRegion(mapRegion, animated: true)
        
        //Location Manager p158
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

        //placemark info label
        /* */
        placeMarksInfoLabel.frame = CGRectMake(55, 520, 270, 100)
        placeMarksInfoLabel.backgroundColor = UIColor.whiteColor()
        placeMarksInfoLabel.layer.borderColor = UIColor.blackColor().CGColor
        placeMarksInfoLabel.numberOfLines = 4
        placeMarksInfoLabel.layer.cornerRadius = 8.0
        placeMarksInfoLabel.textAlignment = NSTextAlignment.Left
        placeMarksInfoLabel.hidden = true
        placeMarksInfoLabel.userInteractionEnabled = true
        placeMarksInfoLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(placeMarksInfoLabel)
        
    }
    
    //12 info when hit (i) button
    func stringifyLocationInfo(placemark:CLPlacemark) {
        locationManager.stopUpdatingLocation()
        placeMarksString = "City: \(placemark.locality)\n" + "Zip: \(placemark.postalCode)\n" + "Country: \(placemark.country)\n" + "(\(placemark.location.coordinate.latitude), \(placemark.location.coordinate.longitude))"
    }
    
    
    //did update locations
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarksArray, error) -> Void in
            
            if(error != nil) {
                println("Error:" + error.description)
                return
            }
            
            //11
            if(placemarksArray.count > 0) {
                let placeMark = placemarksArray[0] as! CLPlacemark
                self.stringifyLocationInfo(placeMark)
            }
            else {
                println("Error with placemark data")
            }
            let ourLocation = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude)
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.55, longitudeDelta: 0.55)
            let mapRegion = MKCoordinateRegion(center: ourLocation, span: mapSpan)
            self.mapView.setRegion(mapRegion, animated: true)
            
        })
    }
    
    func textFieldShouldEndEditing(zipcodeTF: UITextField) -> Bool {
        //println("TextField should end editing method called")
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        return true;
    }
    func textFieldShouldReturn(zipcodeTF: UITextField) -> Bool
        // called when 'return' key pressed. return NO to ignore.
        {
        zipcodeTF.resignFirstResponder()
            return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}