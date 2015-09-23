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
var placeMarksInfoLabel = UITextField()  

class MainViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
        @IBOutlet weak var mapView: MKMapView!
        let locationManager = CLLocationManager()

        //p159 Show my Location
        @IBAction func showMyLocation(sender: AnyObject) {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }

        @IBAction func changeMapType(sender: AnyObject) {
            let segmentor = sender as! UISegmentedControl
            switch segmentor.selectedSegmentIndex {
            case 0: mapView.mapType = MKMapType.Standard
            case 1: mapView.mapType = MKMapType.Satellite
            default: mapView.mapType = MKMapType.Hybrid
            }
        }

        @IBAction func showPlacemarks(sender: AnyObject) {
            //13
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
        
        //5 Location is set here
        let eiffelTowerLocation = CLLocationCoordinate2D(latitude:48.8582 , longitude:2.2945)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let mapRegion = MKCoordinateRegion(center: eiffelTowerLocation, span: mapSpan)
        mapView.setRegion(mapRegion, animated: true)
        
        //6 Annotation
        let eiffelTowerAnnotation = MKPointAnnotation()
        eiffelTowerAnnotation.title = "The Eiffel Tower"
        eiffelTowerAnnotation.subtitle = "Paris, France"
        mapView.addAnnotation(eiffelTowerAnnotation)
        
        //Location Manager p158
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        //placemark info label
        /*
        placeMarksInfoLabel.frame = CGRectMake(38, 100, 300, 200)
        placeMarksInfoLabel.backgroundColor = UIColor.orangeColor()
        placeMarksInfoLabel.layer.borderColor = UIColor.blackColor().CGColor
        placeMarksInfoLabel.numberOfLines = 6
        */
        placeMarksInfoLabel.layer.cornerRadius = 8.0
        placeMarksInfoLabel.textAlignment = NSTextAlignment.Center
        placeMarksInfoLabel.hidden = true
        self.view.addSubview(placeMarksInfoLabel)
        
    }
    
    // 8 view for annotation
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        let pinReuseID = "thePin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(pinReuseID) as? MKPinAnnotationView
        
        if (pinView == nil) {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinReuseID)
            
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView!
    }
    
    
    //12 pop-up info when hit (i) button
    func stringifyLocationInfo(placemark:CLPlacemark) {
        locationManager.stopUpdatingLocation()
        placeMarksString = "Locality: \(placemark.locality)\n" + "Zip-Code: \(placemark.postalCode)\n" + "Country: \(placemark.country)\n" + "Lat/Long: (\(placemark.location.coordinate.latitude), \(placemark.location.coordinate.longitude))\n"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}