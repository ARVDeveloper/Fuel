//
//  ReportViewController.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit
import MaterialComponents
import CoreCharts
class ReportViewController: UIViewController,CoreChartViewDataSource {
    var arrLogs = [LogsModel]()
    var vid = String()
    var month = String()
    @IBOutlet weak var viewChart: VCoreBarChart!
    let cityNames = ["Istanbul","Antalya","Ankara","Trabzon","İzmir"]
    let plateNumber = [34,07,06,61,35]
    @IBOutlet weak var lbltitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbltitle1.text = ""
        lblTitle2.text = ""
        lblTitle3.text = ""
        viewChart.dataSource = self
       
    }
    
    func didTouch(entryData: CoreChartEntry) {
        print(entryData.barTitle)
        lbltitle1.text = entryData.barTitle
        lblTitle2.text = entryData.id + "Liter"
    }
    
    func loadCoreChartData() -> [CoreChartEntry] {
        
        return getTurkeyFamouseCityList()
        
    }
    
    
    func getTurkeyFamouseCityList()->[CoreChartEntry] {
        var allCityData = [CoreChartEntry]()
       
        
        for index in arrLogs {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let date = formatter.date(from: index.date)
            formatter.dateFormat = "dd MMM"
           
            let newEntry = CoreChartEntry(id: index.quantity, barTitle:  formatter.string(from: date!), barHeight: Double(index.quantity) ?? 0.0, barColor: rainbowColor())
            allCityData.append(newEntry)
            
        }
        
        return allCityData
        
    }
    
   
    @IBAction func btnReport(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
