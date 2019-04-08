//
//  ReportViewController.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit
import XJYChart
import MaterialComponents
class ReportViewController: UIViewController,XJYChartDelegate {
    var arrLogs = [LogsModel]()
    var vid = String()
    var month = String()
    @IBOutlet weak var viewChart: MDCCard!
    
    @IBOutlet weak var lbltitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        lbltitle1.text = ""
        lblTitle2.text = ""
        lblTitle3.text = ""
    
        var itemArray: [AnyHashable] = []
        let waveColor = UIColor.wave()
        self.arrLogs = CoreDatamanager.manager.getAllLogs(vid: self.vid, month: month)
        var topnumber  = 0
        for item in self.arrLogs{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let date = formatter.date(from: item.date)
            formatter.dateFormat = "dd MMM"
            let datestr = formatter.string(from: date!)
            var item1 = XBarItem()
            if let value  = Int(item.quantity) {
                item1 = XBarItem(dataNumber:NSNumber.init(value: value), color: waveColor, dataDescribe: datestr)
                if topnumber < value{
                    topnumber = value
                }
           
            }
            if let value  = Double(item.quantity) {
                item1 = XBarItem(dataNumber:NSNumber.init(value: value), color: waveColor, dataDescribe: datestr)
                if topnumber < Int(value){
                    topnumber = Int(value)
                }
              
            }
            itemArray.append(item1)
        }
        
       
        let configuration = XBarChartConfiguration()
        configuration.isScrollable = true
        configuration.x_width = 20
        let barChart = XBarChart(frame: CGRect(x: 0, y: 0, width: viewChart.frame.width, height: viewChart.frame.height), dataItemArray: NSMutableArray(array: itemArray), topNumber: NSNumber.init(value: topnumber), bottomNumber: 0, chartConfiguration: configuration)
        barChart!.barChartDelegate = self
        viewChart.addSubview(barChart!)
        
    }
    func userClickedOnBar(at idx: Int) {
        print(idx)
        if arrLogs.count > idx {
            let item = arrLogs[idx]
            lbltitle1.text = item.quantity + "  " + item.unit
            lblTitle2.text = item.date + "  " + item.price + " per " + item.unit
            lblTitle3.text = item.odometer + " Kms"
        }
       
    }
   
    @IBAction func btnReport(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
