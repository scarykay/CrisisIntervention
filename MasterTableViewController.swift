//  MasterTableViewController.swift

import UIKit
import CoreData

enum EncryptionError: ErrorType {
    case Empty
    case Short
}

class MasterTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, TeamDetailDelegate {

    var teamDetailsArray:Array<AnyObject> = []
    
    var coreDataStack: CoreDataStack!
    //lazy var fetchedResultController: NSFetchedResultsController =
    //self.surfJournalfetchedResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // page123
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //p120
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TeamDetail")
        do {
            try teamDetailsArray = manObjContext.executeFetchRequest(fetchRequest)
        } catch {
            // Do something in response to error condition
        }
        
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return teamDetailsArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("teamDetailCell", forIndexPath: indexPath)
        
        // grab the current teamDetail object from the array
        let currentTeamDetail = teamDetailsArray[indexPath.row] as! TeamDetail
        
        //map
        cell.textLabel?.text = currentTeamDetail.city
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.textLabel?.font = UIFont(name: "Futura", size: 20)
        
        cell.detailTextLabel?.text = "\(currentTeamDetail.state), \(currentTeamDetail.zipcode), \(currentTeamDetail.coordinator) \(currentTeamDetail.phone), \(currentTeamDetail.email), \(currentTeamDetail.name), \(currentTeamDetail.facility)"
        cell.detailTextLabel?.textColor = UIColor.blueColor()
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:12)
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // commit EDITING the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            //1
            let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            //2
            let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
            
            //3
            manObjContext.deleteObject(teamDetailsArray[indexPath.row] as! TeamDetail)
            
            //4
            teamDetailsArray.removeAtIndex(indexPath.row)
            
            // 5 Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //6 save and commit
           /* var error:NSError?
            if !manObjContext.save(&error) {
                abort()
            }
            else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            } */
        }
    }
    
    
    /*  // Override to support rearranging the table view.   */
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - JournalEntryDelegate
    
    func didFinishViewController(
        viewController:DetailsViewController, didSave:Bool) {
            
            // 1
            if didSave {
            // 2
             //var error: NSError? = nil
              /*do {
                var context = viewController.context
                context = try context.performBlock({ () -> Void in
                },
                } catch {
                    print("Couldn't save")
                    abort()
                  }
              }*/
            // 3
            self.coreDataStack.saveContext()
   
            // 4
            dismissViewControllerAnimated(true, completion: {})
    }
}
    
    // MARK: - Segues
    
    /*In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue" {
            //let indexPath = self.tableView.indexPathForSelectedRow!
            _ = self.tableView.indexPathForSelectedRow!.row
            _ = segue.destinationViewController as! UINavigationController
            
            //let detailViewController = navigationController.topViewController as! MasterTableViewController
            //let surfJournalEntry = fetchedResultController.objectAtIndexPath(indexPath!) as! TeamDetail
            
            
            // 1
            let childContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            childContext.parentContext = coreDataStack.context
            
            // 2
            //let childEntry = childContext.objectWithID( surfJournalEntry.objectID) as! TeamDetail
            
            // 3
            //detailViewController.journalEntry = childEntry
            //detailViewController.context = childContext
            //detailViewController.delegate = self
            
        } else if segue.identifier == "addItemSegue" {
            
            //_ = segue.destinationViewController as! UINavigationController
            //let detailViewController = navigationController.topViewController as! MasterTableViewController
            
            
            //let teamDetalEntity = NSEntityDescription.entityForName("TeamDetail", inManagedObjectContext: coreDataStack.context)
            //_ = TeamDetail(entity: teamDetalEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            //detailViewController.journalEntry = newJournalEntry
            //detailViewController.context = newJournalEntry.managedObjectContext
            //detailViewController.delegate = self
        }

                    
        
        /*//pg121*/
        if (segue.identifier == "detailsSegue"){
            _ = self.tableView.indexPathForSelectedRow!.row
            print("hi")
            //let selectedTeamDetail = teamDetailsArray[selectedItemIndexPath!] as! TeamDetail
            _ = segue.destinationViewController as! DetailsViewController
            //detailsScreen.featuredItem = selectedTeamDetail
        }
    }
}