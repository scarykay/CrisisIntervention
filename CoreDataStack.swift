/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
raywenderlich.com/84642/multiple-managed-object-contexts-in-core-data-tutorial
*/

import CoreData

public class CoreDataStack {
  
  let context:NSManagedObjectContext
  let psc:NSPersistentStoreCoordinator
  let model:NSManagedObjectModel
  var store:NSPersistentStore?
  
  public init() {
    
    let modelName = "CrisisInterventionModel"
    let databaseName = "CrisisIntervention.sqlite"
    
    let bundle = NSBundle.mainBundle()
    let modelURL =
      bundle.URLForResource(modelName, withExtension:"momd")
    model = NSManagedObjectModel(contentsOfURL: modelURL!)!
    
    psc =
      NSPersistentStoreCoordinator(managedObjectModel:model)
    
    context = NSManagedObjectContext(
      concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    let documentsURL = applicationDocumentsDirectory()
    let storeURL =
      documentsURL.URLByAppendingPathComponent(databaseName)
    
    // 1
    let seededDatabaseURL = bundle
      .URLForResource("CrisisIntervention",
        withExtension: "sqlite")
    
    // 2
    var fileManagerError:NSError? = nil
    let didCopyDatabase = NSFileManager.defaultManager()
      .copyItemAtURL(seededDatabaseURL!, toURL: storeURL,
        error: &fileManagerError)
    
    // 3
    if didCopyDatabase {
      
      // 4
      fileManagerError = nil
      let seededSHMURL = bundle
        .URLForResource("CrisisIntervention",
          withExtension: "sqlite-shm")
      let shmURL = documentsURL.URLByAppendingPathComponent(
        "CrisisIntervention.sqlite-shm")
      
      let didCopySHM = NSFileManager.defaultManager()
        .copyItemAtURL(seededSHMURL!, toURL: shmURL,
          error: &fileManagerError)
      if !didCopySHM {
        println("Error seeding Core Data: \(fileManagerError)")
        abort()
      }
      
      // 5
      fileManagerError = nil
      let walURL = documentsURL.URLByAppendingPathComponent(
        "CrisisIntervention.sqlite-wal")
      let seededWALURL = bundle
        .URLForResource("CrisisIntervention",
          withExtension: "sqlite-wal")
      
      let didCopyWAL = NSFileManager.defaultManager()
        .copyItemAtURL(seededWALURL!, toURL: walURL,
          error: &fileManagerError)
      if !didCopyWAL {
        println("Error seeding Core Data: \(fileManagerError)")
        abort()
      }
      
      println("Seeded Core Data")
    }
    
    // 6 add the seeded database store to the persistent store coordinator
    var error: NSError? = nil
    let options = [NSInferMappingModelAutomaticallyOption:true,
      NSMigratePersistentStoresAutomaticallyOption:true]
    store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
      configuration: nil,
      URL: storeURL,
      options: options,
      error: &error)

    // 7
    if store == nil {
      println("Error adding persistent store: \(error)")
      abort()
    }
  }
  
  func applicationDocumentsDirectory() -> NSURL {
  
    let fileManager = NSFileManager.defaultManager()
  
    let urls =
      fileManager.URLsForDirectory(.DocumentDirectory,
        inDomains: .UserDomainMask) as! [NSURL]
  
    return urls[0]
  }
  
  func saveContext() {
    context.performBlock { () -> Void in
      var error: NSError? = nil
      if self.context.hasChanges && !self.context.save(&error) {
        println("Could not save: \(error), \(error?.userInfo)")
        abort()
      }
    }
  }
  
}
