//
//  MainViewController.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 9/23/15.
//  Copyright (c) 2015 Mary K Paquette. All rights reserved.
//


import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var zipcodeTF: UITextField! = nil
    var myZip:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipcodeTF.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
         // UITextField Delegates
        func textFieldShouldEndEditing(zipcodeTF: UITextField) -> Bool {
            //println("TextField should end editing method called")
            //locationManager.startUpdatingLocation()
            //mapView.showsUserLocation = true
            return true;
        }
        func textFieldShouldReturn(zipcodeTF: UITextField) -> Bool
            // called when 'return' key pressed. return NO to ignore.
        {
            zipcodeTF.resignFirstResponder()
            return true;
        }
        
    }

    
    @IBAction func findCIT(sender: AnyObject) {
        if zipcodeTF.text != nil {
            zipcodeTF.text = (myZip) as String
        } else {
            //catch
            print("nothing caught")
        }
    }
    
    /*
func compareZip() {
            //compare to all zips in db - using predicate
            //display matching club in the MasterTable
            print("comparing now")
        }
*/

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of resources that can be recreated.
    }

}
    