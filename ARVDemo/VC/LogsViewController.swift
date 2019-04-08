//
//  LogsViewController.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit

class LogsViewController: UIViewController {
    
    @IBOutlet weak var btnprevious: UIButton!
    @IBOutlet weak var btnCurrentmonth: UIButton!
    @IBOutlet weak var btn2ndPrevious: UIButton!
    @IBOutlet weak var tbleView: UITableView!
    let currentDate = Date()
    var str2ndpre = "05"
    var strPre = "03"
    var strcurr = "03"
    var arrLogs = [LogsModel]()
    var vid = String()
    var month = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let prepreviouDate = currentDate.get2PreMonth()
        let previouDate = currentDate.getPreviousMonth()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        self.btnCurrentmonth.setTitle(formatter.string(from: currentDate), for: .normal)
        self.btnprevious.setTitle(formatter.string(from: previouDate!), for: .normal)
        self.btn2ndPrevious.setTitle(formatter.string(from: prepreviouDate!), for: .normal)
        formatter.dateFormat = "MM"
        str2ndpre = formatter.string(from: prepreviouDate!)
        strPre = formatter.string(from: previouDate!)
        strcurr = formatter.string(from: currentDate)
        month = formatter.string(from: currentDate)
        print(strcurr,strPre,str2ndpre)
        btnCurrentmonth.setTitleColor(UIColor.peach(), for: .normal)
        btnprevious.setTitleColor(UIColor.darkGray, for: .normal)
        btn2ndPrevious.setTitleColor(UIColor.darkGray, for: .normal)
   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.arrLogs = CoreDatamanager.manager.getAllLogs(vid: self.vid, month: strcurr)
        tbleView.reloadData()
    }
    @IBAction func btnreprot(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        vc.vid = vid
        vc.month = month
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnAddLog(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "AddlogViewController") as! AddlogViewController
        vc.vid = vid
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn2ndPre(_ sender: Any) {
        btn2ndPrevious.setTitleColor(UIColor.peach(), for: .normal)
        btnCurrentmonth.setTitleColor(UIColor.darkGray, for: .normal)
        btnprevious.setTitleColor(UIColor.darkGray, for: .normal)
        month = str2ndpre
        self.arrLogs = CoreDatamanager.manager.getAllLogs(vid: self.vid, month: month)
        tbleView.reloadData()
    }
    
    @IBAction func btnCurrent(_ sender: Any) {
        btnCurrentmonth.setTitleColor(UIColor.peach(), for: .normal)
        btnprevious.setTitleColor(UIColor.darkGray, for: .normal)
        btn2ndPrevious.setTitleColor(UIColor.darkGray, for: .normal)
        month = strcurr
        self.arrLogs = CoreDatamanager.manager.getAllLogs(vid: self.vid, month: month)
        tbleView.reloadData()
    }
    @IBAction func btnPrevious(_ sender: Any) {
        btnprevious.setTitleColor(UIColor.peach(), for: .normal)
        btn2ndPrevious.setTitleColor(UIColor.darkGray, for: .normal)
        btnCurrentmonth.setTitleColor(UIColor.darkGray, for: .normal)
        month = strPre
        self.arrLogs = CoreDatamanager.manager.getAllLogs(vid: self.vid, month: month)
        tbleView.reloadData()
    }
    
}
extension LogsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogsTableViewCell", for: indexPath) as! LogsTableViewCell
        cell.configureCell(log: arrLogs[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDatamanager.manager.deleteLog(log:arrLogs[indexPath.row])
            arrLogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
    
}
extension Date {
    func get2PreMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -2, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}
