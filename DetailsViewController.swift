//
//  DetailsViewController.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 9/11/15.
//  Copyright (c) 2015 Mary K Paquette. All rights reserved.
//


import UIKit
import CoreData

protocol TeamDetailDelegate {
    
    func didFinishViewController(
        viewController:DetailsViewController, didSave:Bool)
    
}


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    
    @IBOutlet weak var coordinatorTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField! //dispatch
    
    @IBOutlet weak var facilityTF: UITextField!
    
    /*var journalEntry: TeamDetail! {
        didSet {
            self.configureView()
        }
    }*/
    
    var context: NSManagedObjectContext!
    var delegate:TeamDetailDelegate?
    
    
    
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
        //self.navigationController?.popToViewController(navigationController!.viewControllers[0] , animated: true)
        self.navigationController?.popToRootViewControllerAnimated(true)
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
            featuredItem?.zipcode = zipcodeTF.text
            featuredItem?.coordinator = coordinatorTF.text
            featuredItem?.email = emailTF.text
            featuredItem?.phone = phoneTF.text
            featuredItem?.name = nameTF.text
            featuredItem?.facility = facilityTF.text
            
        }
        else {
            //3.1
            let newTeamDetail:TeamDetail = NSEntityDescription.insertNewObjectForEntityForName("TeamDetail", inManagedObjectContext: manObjContext) as! TeamDetail
            newTeamDetail.city = cityTF.text
            newTeamDetail.state = stateTF.text
            newTeamDetail.zipcode = zipcodeTF.text
            newTeamDetail.coordinator = coordinatorTF.text
            newTeamDetail.email = emailTF.text
            newTeamDetail.phone = phoneTF.text
            newTeamDetail.name = nameTF.text
            newTeamDetail.facility = facilityTF.text
            
        }
        
        do {
            //4 Attributes are assigned the values
            try manObjContext.save()
        } catch _ {
        }
        print ("A new object was created.")
        do {
            // println ("A new object was created - - - \(featuredProjectItem.description)")
    
            
            //5 Save the changes to storage
            try manObjContext.save()
        } catch _ {
        }
        
        //6
        //self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popToViewController(navigationController!.viewControllers[1] , animated: true)
    
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

