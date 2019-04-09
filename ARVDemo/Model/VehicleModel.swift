//
//  Vehicle.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit

class VehicleModel: NSObject {
    var id : String!
    var name: String!
    var type: String!
    var odometer: String!
    var number: String!
    
    func saveData(vehicle:VehicleModel){
        CoreDatamanager.manager.setVehicle(vehicle:vehicle)
    }
    
    func getdata()->[VehicleModel]{
        return CoreDatamanager.manager.getAllVehicle()
    }
    func deleteVihicle(vehicle:VehicleModel){
        return CoreDatamanager.manager.deleteVehicle(vehicle:vehicle)
    }
}
