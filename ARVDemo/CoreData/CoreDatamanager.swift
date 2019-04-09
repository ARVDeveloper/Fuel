//
//  CoreDatamanager.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit
import CoreData
class CoreDatamanager: NSObject {
    static let manager = CoreDatamanager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func setVehicle(vehicle:VehicleModel) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Vehicle", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
       
        newUser.setValue(vehicle.id, forKey: "id")
        newUser.setValue(vehicle.name, forKey: "name")
        newUser.setValue(vehicle.odometer, forKey: "odometer")
        newUser.setValue(vehicle.type, forKey: "type")
        newUser.setValue(vehicle.number, forKey: "number")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    func getAllVehicle()->[VehicleModel]{
        var arrVehicleModel = [VehicleModel]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                let vModel = VehicleModel()
                vModel.name = data.value(forKey: "name") as? String
                vModel.id = data.value(forKey: "id") as? String
                vModel.odometer = data.value(forKey: "odometer") as? String
                vModel.type = data.value(forKey: "type") as? String
                vModel.number = data.value(forKey: "number") as? String
                arrVehicleModel.append(vModel)
            }
        } catch {
            
            print("Failed")
        }
        return arrVehicleModel
    }
    func deleteVehicle(vehicle:VehicleModel){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
        request.predicate = NSPredicate.init(format: "id==\(vehicle.id ?? "")")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            
        }
       
    }
    func setlog(log:LogsModel) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FuelLog", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(log.id, forKey: "id")
        newUser.setValue(log.vid, forKey: "vID")
        newUser.setValue(log.date, forKey: "date")
        newUser.setValue(log.unit, forKey: "unit")
        newUser.setValue(log.quantity, forKey: "quantity")
        newUser.setValue(log.odometer, forKey: "odometer")
        newUser.setValue(log.price, forKey: "price")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    func getAllLogs(vid:String,month:String)->[LogsModel]{
        var arrLogsModel = [LogsModel]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FuelLog")
       
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "vID") as! String)
                let date  = data.value(forKey: "date") as! String
                let arrdate = date.components(separatedBy: "/")
                if data.value(forKey: "vID") as! String == vid && arrdate[1] == month{
                    let lModel = LogsModel()
                    
                    lModel.id = data.value(forKey: "id") as? String
                    lModel.vid = data.value(forKey: "vID") as? String
                    lModel.date = data.value(forKey: "date") as? String
                    lModel.quantity = data.value(forKey: "quantity") as? String
                    lModel.unit = data.value(forKey: "unit") as? String
                    lModel.odometer = data.value(forKey: "odometer") as? String
                    lModel.price = data.value(forKey: "price") as? String
                    arrLogsModel.append(lModel)
                }
                
            }
        } catch {
            
            print("Failed")
        }
        return arrLogsModel
    }
    func deleteLog(log:LogsModel){
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FuelLog")
        request.predicate = NSPredicate.init(format: "id==\(log.id ?? "")")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            
        }
        
    }
}
