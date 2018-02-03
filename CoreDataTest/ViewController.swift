//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Volta on 2/2/18.
//  Copyright © 2018 Jake. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: Variables
    
    // Declare User Managed Object (will contain the data we want)
    var User: [NSManagedObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Derived from: https://www.raywenderlich.com/173972/getting-started-with-core-data-tutorial-2
        
        // Instantiate appDelegate and managedContext
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // Create a request to the core stack to retrieve data
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        // Fetch data and store result in User
        do {
            User = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Print out first User data entry's name
        //let user = User[0]
        //print(user.value(forKey: "name")!)
        
        // Call to save function
        save(name: "Pete")
    }
    
    /*
     * This function saves the string argument to core data
     */
    func save(name: String) {
        
        // Instatiate appDelegate and managedContext
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Declare user object to hold the first User data entry
        var user : NSObject
        
        // If no User data entry, initialize an entry.  Else work with first entry.
        if (User.count == 0)
        {
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
            user = NSManagedObject(entity: entity, insertInto: managedContext)
        }
        else
        {
            user = User[0]
        }

        // Set entry value for name
        user.setValue(name, forKeyPath: "name")
        
        // Perform save built in save function
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

