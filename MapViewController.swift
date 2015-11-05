//
//  MapViewController.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 10/22/15.
//  Copyright © 2015 Mary K Paquette. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var infoPocketLabel: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let region = mapView.region;
        
        
        let cla = round(region.center.latitude * 100.0) / 100.0
        let clo = round(region.center.longitude * 100.0) / 100.0
        
        let center = CLLocation(latitude:  cla,
            longitude: clo)
        
        //note this works for US hemisphere
        let upperLeft = CLLocationCoordinate2DMake(
            region.center.latitude - region.span.latitudeDelta,
            region.center.longitude + region.span.longitudeDelta)
        let corner = CLLocation(latitude:  upperLeft.latitude,
            longitude: upperLeft.longitude)
        // mapView.removeAnnotations(mapView.annotations);
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // let myZip = infoPocketLabel.text
        
    //predicate (filter match)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailsssSegue"){
            
      // Pass the selected object to the new controller
      //var weatherScreen:MapViewController =
       //let weatherScreen =
           // segue.destinationViewController as! MapViewController
        print(infoPocketLabel.text)
       // weatherScreen.zipcode = myZip.text

        }
        
    }


}
