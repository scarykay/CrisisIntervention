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
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    
    @IBOutlet weak var coordinatorTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField! //dispatch
    
    @IBOutlet weak var facilityTF: UITextField!
    
    
    var featuredItem:TeamDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // page 121
        if(featuredItem != nil){
            cityTF.text = featuredItem!.city
            stateTF.text = "\(featuredItem!.state)"
            zipcodeTF.text = "\(featuredItem!.zipcode)"
            coordinatorTF.text = "\(featuredItem!.coordinator)"
            emailTF.text = "\(featuredItem!.email)"
            phoneTF.text = "\(featuredItem!.phone)"
            nameTF.text = "\(featuredItem!.name)"
            facilityTF.text = "\(featuredItem!.facility)"
            
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
            featuredItem?.state = stateTF.text
            featuredItem?.zipcode = NSString(format: zipcodeTF.text).integerValue
            featuredItem?.coordinator = coordinatorTF.text
            featuredItem?.email = emailTF.text
            featuredItem?.phone = phoneTF.text
            featuredItem?.name = nameTF.text
            featuredItem?.facility = facilityTF.text
            
        }
        else {
            //3.1
            var newTeamDetail:TeamDetail = NSEntityDescription.insertNewObjectForEntityForName("TeamDetail", inManagedObjectContext: manObjContext) as! TeamDetail
            newTeamDetail.city = cityTF.text
            newTeamDetail.state = stateTF.text
            newTeamDetail.zipcode = NSString(string: zipcodeTF.text).integerValue
            newTeamDetail.coordinator = coordinatorTF.text
            newTeamDetail.email = emailTF.text
            newTeamDetail.phone = phoneTF.text
            newTeamDetail.name = nameTF.text
            newTeamDetail.facility = facilityTF.text
            
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

