//
//  CoreDataManager.swift
//  NewSwiftDemo
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 vp. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {
  
    static let sharedCDManager = CoreDataManager()
    
    typealias CompletionHandler = (_ success:Any) -> Void
    typealias ErrorHandler = (_ error: NSError) -> Void
    var arrCoreEntity = [NSManagedObject]()
    
    //MARK: Core Date Methods- Save the data to Core data
    func saveEntityData(entityParams: [String: AnyObject], entityName: String, result:CompletionHandler) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else{
            print("Failed")
            return
        }
        let dataRecord = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //Set Your Parametres To Entity Attributes From EntityParams Dictionary according to your Entity
        let deviceBrand = entityParams["deviceBrand"]! as! String
        let deviceModel = entityParams["deviceModel"]! as! String
        let devicePrice = entityParams["devicePrice"]! as! String
        let deviceColour = entityParams["deviceColour"]! as! String
        
        dataRecord.setValue(deviceBrand, forKeyPath: "deviceBrand")
        dataRecord.setValue(deviceModel, forKeyPath: "deviceModel")
        dataRecord.setValue(devicePrice, forKeyPath: "devicePrice")
        dataRecord.setValue(deviceColour, forKeyPath: "deviceColour")
        do {
            try managedContext.save()
            let resultVal = true
            result(resultVal)
            print("save.")
        } catch let error as NSError {
            let resultVal = false
            result(resultVal)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Get data from Core Data
    func getEntityData(entityName: String, result:CompletionHandler, failerror:ErrorHandler) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            arrCoreEntity = try managedContext.fetch(fetchRequest)
            result(arrCoreEntity)
        } catch let error as NSError {
            failerror(error as NSError)
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    //MARK: Update Records
    func updateUserData(entityParams: [String: AnyObject], entityName: String, result:CompletionHandler) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        //Set Entity key Name According to your Entity Model
        let name = entityParams["name"]! as! String
        let predicate = NSPredicate(format: "name = '\(name)'")
        fetchRequest.predicate = predicate
        let managedContext = appDelegate.persistentContainer.viewContext
        //Set Your Parametres To Entity Attributes From EntityParams Dictionary according to your Entity
        let email = entityParams["email"]! as! String
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1
            {
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(name, forKey: "name")
                objectUpdate.setValue(email, forKey: "email")
                do{
                    try managedContext.save()
                    let resultVal = true
                    result(resultVal)
                }
                catch
                {
                    let resultVal = false
                    result(resultVal)
                    print(error)
                }
            }
        }
        catch
        {
            let resultVal = false
            result(resultVal)
            print(error)
        }
    }
    //MARK: Core Data: Delete data from core data table
    
    func deleteEntityData(name: String, entityName: String, result:CompletionHandler) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        
        //Set Entity key Name According to your Entity Model
        let predicate = NSPredicate(format: "name = '\(name)'")
        
        fetchRequest.predicate = predicate
        let managedContext = appDelegate.persistentContainer.viewContext
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1
            {
                let objectDelete = test[0] as! NSManagedObject
                managedContext.delete(objectDelete)
                do{
                    try managedContext.save()
                    let resultVal = true
                    result(resultVal)
                }
                catch
                {
                    let resultVal = false
                    result(resultVal)
                    print(error)
                }
            }
        }
        catch
        {
            let resultVal = false
            result(resultVal)
            print(error)
        }
    }
}
