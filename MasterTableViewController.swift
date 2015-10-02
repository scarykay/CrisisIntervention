//  MasterTableViewController.swift

import UIKit
import CoreData

class MasterTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,TeamDetailDelegate {
    
    var coreDataStack: CoreDataStack!
    lazy var fetchedResultController: NSFetchedResultsController = self.surfJournalFetchedResultController()
    
    var teamDetailsArray:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // page123
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //--------- inserted
        // MARK: - NSFetchedResultsController
        
        override func surfJournalFetchedResultController() -> NSFetchedResultsController {
                fetchedResultController =
                    NSFetchedResultsController(fetchRequest: surfJournalFetchRequest(),
                        managedObjectContext: coreDataStack.context,
                        sectionNameKeyPath: nil,
                        cacheName: nil)
                
                fetchedResultController.delegate = self
                
                var error: NSError? = nil
                if (!fetchedResultController.performFetch(&error)){
                    println("Error: \(error?.localizedDescription)")
                    abort()
                }
                
                return fetchedResultController
        }
        
        override func surfJournalFetchRequest() -> NSFetchRequest {
            
            let fetchRequest = NSFetchRequest(entityName: "TeamDetail")
            fetchRequest.fetchBatchSize = 20
            
            let sortDescriptor =
            NSSortDescriptor(key: "zipcode", ascending: false)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            return fetchRequest
        }
        
        
        // MARK: - NSFetchedResultsControllerDelegate
        
        override func controllerDidChangeContent(controller:
            NSFetchedResultsController) {tableView.reloadData()
        }
        
//---------
        
    }
    
    
    /*override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TeamDetail")
        teamDetailsArray = manObjContext.executeFetchRequest(fetchRequest, error: nil)!
        self.tableView.reloadData()
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
        //return fetchedResultController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return teamDetailsArray.count
        //return fetchedResultController.sections![section].numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("teamDetailCell", forIndexPath: indexPath) as! UITableViewCell
        
        /* if using separate swift file to format cell ------------------------------
        func configureCell(cell: SurfEntryTableViewCell, indexPath:NSIndexPath) {
         */
        let surfJournalEntry = fetchedResultController.objectAtIndexPath(indexPath) as! TeamDetail
       
        
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
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // commit EDITING the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
            if editingStyle == .Delete {
            let surfTeamDetail = fetchedResultController.objectAtIndexPath(indexPath) as! TeamDetail
           // coreDataStack.context.deleteObject(surfJournalEntry)
            coreDataStack.context.deleteObject(teamDetailsArray[indexPath.row] as! TeamDetail)
            coreDataStack.saveContext()
            }
        
        /*   if editingStyle == .Delete {
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
            var error:NSError?
            if !manObjContext.save(&error) {
                abort()
            }
            */
            else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
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

    //----- more insert -----------
    // MARK: - JournalEntryDelegate

    override func didFinishViewController(viewController:DetailsViewController, didSave:Bool) {
        
        // 1
        if didSave {
            // 2
            var error: NSError? = nil
            let context = viewController.context
            context.performBlock({ () -> Void in
                if context.hasChanges && !context.save(&error) {
                    println(
                        "Couldn't save: \(error), \(error?.userInfo)")
                    abort()
                }
                // 3
                self.coreDataStack.saveContext()
            })
        }
        
        // 4
        dismissViewControllerAnimated(true, completion: {})
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*//pg121
        if (segue.identifier == "detailsSegue"){
            let selectedItemIndexPath = self.tableView.indexPathForSelectedRow()?.row
            let selectedTeamDetail = teamDetailsArray[selectedItemIndexPath!] as! TeamDetail
            let detailsScreen = segue.destinationViewController as! DetailsViewController
            detailsScreen.featuredItem = selectedTeamDetail
        } */
        
        
        if segue.identifier == "detailsSegue" {
            
           // let indexPath = tableView.indexPathForSelectedRow()
            //let surfJournalEntry = fetchedResultController.objectAtIndexPath(indexPath!) as! TeamDetail
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let detailViewController = navigationController.topViewController as! DetailsViewController
            
            // 1
            let childContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            childContext.parentContext = coreDataStack.context
            
            // 2
            let childEntry = childContext.objectWithID(surfJournalEntry.objectID) as! TeamDetail
            
            // 3
            detailViewController.TeamDetail = childEntry
            detailViewController.context = childContext
            detailViewController.delegate = self
            
        } else if segue.identifier == "addItemSegue" {
            
            let navigationController =
            segue.destinationViewController as! UINavigationController
            let detailViewController = navigationController.topViewController as! DetailsViewController
            
            
            let teamDetailEntity = NSEntityDescription.entityForName("TeamDetail", inManagedObjectContext: coreDataStack.context)
            let newTeamDetail = TeamDetail(entity: TeamDetailEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            detailViewController.TeamDetail = newTeamDetail
            detailViewController.context = newTeamDetail.managedObjectContext
            detailViewController.delegate = self
        }
   }

