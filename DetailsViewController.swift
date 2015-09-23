//
//  DetailsViewController.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 9/11/15.
//  Copyright (c) 2015 Mary K Paquette. All rights reserved.
//


import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var coordinatorTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var facilityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
   
    
    var featuredItem:TeamDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // page 121
        if(featuredItem != nil){
            cityTF.text = featuredItem!.city
            coordinatorTF.text = "\(featuredItem!.coordinator)"
            emailTF.text = "\(featuredItem!.email)"
            facilityTF.text = "\(featuredItem!.facility)"
            stateTF.text = "\(featuredItem!.state)"
            zipcodeTF.text = "\(featuredItem!.zipcode)"
            
        }
    }
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // this now goes all the way HOME ------ [0]
        self.navigationController?.popToViewController(navigationController!.viewControllers[0] as! UIViewController, animated: true)
    }
    
    
    @IBAction func saveItem(sender: UIBarButtonItem) {
        //1 get a reference to the appDelegate
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // 2 get Context
        let manObjContext: NSManagedObjectContext = theAppDelegate.managedObjectContext!
        
        //3 create an instance of the class for a given name
        //Check if its an already existing detail
        if (featuredItem != nil){
            featuredItem?.city = cityTF.text
            featuredItem?.coordinator = coordinatorTF.text
            featuredItem?.email = emailTF.text
            featuredItem?.facility = facilityTF.text
            featuredItem?.state = stateTF.text
            featuredItem?.zipcode = NSString(format: "%@", zipcodeTF.text).integerValue
            
        }
        else {
            //3.1
            var newTeamDetail:TeamDetail = NSEntityDescription.insertNewObjectForEntityForName("TeamDetail", inManagedObjectContext: manObjContext) as! TeamDetail
            newTeamDetail.city = cityTF.text
            newTeamDetail.coordinator = coordinatorTF.text
            newTeamDetail.email = emailTF.text
            newTeamDetail.facility = facilityTF.text
            newTeamDetail.state = stateTF.text
            newTeamDetail.zipcode = NSString(format: "%@", zipcodeTF.text).integerValue
            
        }
        
        
        //4 Attributes are assigned the values
        manObjContext.save(nil)
        println ("A new object was created.")
        // println ("A new object was created - - - \(featuredProjectItem.description)")
    
        
        //5 Save the changes to storage
        manObjContext.save(nil)
        
        //6
        //self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popToViewController(navigationController!.viewControllers[1] as! UIViewController, animated: true)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

