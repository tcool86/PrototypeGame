//
//  AppDelegate.swift
//  gameTest
//
//  Created by Timothy Cool on 5/5/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//


import Cocoa
import CoreData

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var persistentContainer : NSPersistentContainer = NSPersistentContainer(name: "StarGameModel")

    func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            let contextError = error as NSError
            fatalError("Error: \(contextError), \(contextError.userInfo)")
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        })
        let now : Date = Date()
        let seed : Int = Int(now.timeIntervalSince1970)
        srand48(seed)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}
