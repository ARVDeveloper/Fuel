//
//  LogsModel.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit

class LogsModel: NSObject {
    var id : String!
    var vid : String!
    var date: String!
    var unit: String!
    var quantity: String!
    var odometer: String!
     var price: String!
    func saveData(log:LogsModel){
        CoreDatamanager.manager.setlog(log:log)
    }
    
    func getdata(vid:String)->[LogsModel]{
        return CoreDatamanager.manager.getAllLogs(vid: vid, month: "04")
    }
    func deleteData(log:LogsModel){
        CoreDatamanager.manager.deleteLog(log:log)
    }
}
