//
//  Memory_CoreDataStack.swift
//  ColeDeonslow_CE4Adaptive LayoutProject
//
//  Created by Deon Cole on 4/28/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

//Import CoreData and the custom CoreData Stack

import Foundation
import CoreData


class Memory_CoreDataStack {
    
    //Our Notepad
    let context: NSManagedObjectContext!
    
    //The Workhorse. This coordinates everything between our Objects, Context and Persistent Store (the hard drive)
    let persistentStoreCoordinator: NSPersistentStoreCoordinator!
    
    //We model our data in the .xcdatamodel file in xcode
    //We create entities and attributes etc.
    //This property will represent our entire .xcdatamodel file once setup
    let objModel:NSManagedObjectModel
    
    //SQLite? XML? Binary? Reads/Write data in whatever format we choose
    let store: NSPersistentStore?
    
    
    init(){
        // 1. Set up our object model. Need to add a xcdatamodel file to add to the url parameter
        let xcDataModeURL = NSBundle.mainBundle().URLForResource("MemCDStackDM", withExtension: "momd")
        
        //We're force unwrapping. This will crash if the filepath isn't correct.
        objModel = NSManagedObjectModel(contentsOfURL: xcDataModeURL!)!
        
        //2. Use ObjModel to set up Store Coordiantor
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objModel)
        
        //3. Use Store Coordinator to setup the ObjContext
        context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        //4. Use Store Coordinator to setup Persistent Store
        
        //a. Get the URL to our documents directory
        let directories: [NSURL] = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        //b. Create a nw url file path in which to save this application's data by appending to the directory path. The folder to save it to.
        let storeURL = directories[0].URLByAppendingPathComponent("MemCDStack_Data")
        
        //c. Create a directory of options
        let storeOptions = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        //d. set our stores value
        do {
            /* Sometimes you know a throwing function or method won't, in fact, throw an error at runtime. On those occasions, you can write try! before the wxpression to disable error prpagationand wrap the call ina runtime assertions that no error will be thrown/ If an error actually is thrown you'll get a runtime error.*/
            
            //Thatls fine with us if teh Core Data Setup isn't working, crashing will alert us to that fact
            store = try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: storeOptions)
        }
    }
    
    func saveContext(){
        if context.hasChanges {
            do{
                try context.save()
            }
            catch {
                //Replace this implementation with te code to handle the error appropriately
                //abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}