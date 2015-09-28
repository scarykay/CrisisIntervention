//  CITCollectionViewController.swift
//stackoverflow.com/questions/31582378/ios-8-swift-tableview-with-embedded-collectionview


import UIKit
import CoreData

class CITCollectionViewController: UITableViewController {
    // Part ONE 
    var ttableView: UITableView!
    var teamDetailsArray:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ttableView = UITableView(frame: self.view.bounds)
        ttableView.delegate = self
        ttableView.dataSource = self
        self.view.addSubview(ttableView)
        
        ttableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cellCollection")
        ttableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "NormalCell")
    }
    
  /*  override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TeamDetail")
        teamDetailsArray = manObjContext.executeFetchRequest(fetchRequest, error: nil)!
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
       // return teamDetailsArray.count
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        // the old cell info
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCollection", forIndexPath: indexPath) as! UITableViewCell
        
        // grab the current teamDetail object from the array
        var currentTeamDetail = teamDetailsArray[indexPath.row] as! TeamDetail
       
        //map
        cell.textLabel?.text = currentTeamDetail.city
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.textLabel?.font = UIFont(name: "Futura", size: 20)
        
        cell.detailTextLabel?.text = "\(currentTeamDetail.state), \(currentTeamDetail.zipcode), \(currentTeamDetail.coordinator) \(currentTeamDetail.phone), \(currentTeamDetail.email), \(currentTeamDetail.name), \(currentTeamDetail.facility)"
        cell.detailTextLabel?.textColor = UIColor.blueColor()
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:12)
        return cell
      */
        /**/ if indexPath.row == 3 {
            var cell: TableViewCell = tableView.dequeueReusableCellWithIdentifier("cellCollection", forIndexPath: indexPath) as! TableViewCell
            cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
            return cell
            
        } else {
            var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("NormalCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "cell: \(indexPath.row)"
            
            return cell
        }  /**/
    }
}