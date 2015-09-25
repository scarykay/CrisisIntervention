//
//  TeamCollectionVC.swift
//  CrisisIntervention
//
//  Created by Mary K Paquette on 9/25/15.
//  Copyright (c) 2015 Mary K Paquette. All rights reserved.
//

import UIKit
import CoreData

let reuseIdentifier = "TeamDetails"

class TeamCollectionVC: UICollectionViewController {
    
    // copied from master table v.c.
    var teamDetailsArray:Array<AnyObject> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TeamDetail")
        teamDetailsArray = manObjContext.executeFetchRequest(fetchRequest, error: nil)!
        self.collectionView!.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return teamDetailsArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TeamEntry", forIndexPath: indexPath) as! UICollectionViewCell
        // Configure the cell
        // grab the current teamDetail object from the array
        var currentTeamDetail = teamDetailsArray[indexPath.row] as! TeamDetail
        
        //map
          /*
cell.headerCell?.text = currentTeamDetail.city
      
cell.textLabel?.textColor = UIColor.blueColor()
cell.textLabel?.font = UIFont(name: "Futura", size: 20)

cell.detailTextLabel?.text = "\(currentTeamDetail.state), \(currentTeamDetail.zipcode), \(currentTeamDetail.coordinator) \(currentTeamDetail.phone), \(currentTeamDetail.email), \(currentTeamDetail.name), \(currentTeamDetail.facility)"
cell.detailTextLabel?.textColor = UIColor.blueColor()
cell.detailTextLabel?.font = UIFont(name: "Arial", size:12)

*/
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
