//
//  AddlogViewController.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit
import MaterialComponents
class AddlogViewController: UIViewController {
    
    @IBOutlet weak var odometr: MDCTextField!
    @IBOutlet weak var txtDate: MDCTextField!
    @IBOutlet weak var txtType: MDCTextField!
    @IBOutlet weak var txtPrice: MDCTextField!
    @IBOutlet weak var txtQty: MDCTextField!
    var vid = String()
    let thePicker = UIPickerView()
    let datePicker = UIDatePicker()
    var types = ["Liter","Gallon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.showDatePicker()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let lModel = LogsModel()
        lModel.id = "\(Int(CACurrentMediaTime()))"
        lModel.vid =  self.vid
        lModel.date = txtDate.text!
        lModel.unit = txtType.text!
        lModel.quantity = txtQty.text!
        lModel.odometer = odometr.text!
        lModel.price = txtPrice.text!
        lModel.saveData(log: lModel)
        self.navigationController?.popViewController(animated: true)
        self.showalert(message: "Log add Succesfully.", title: "Succes")
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setup(){
        thePicker.delegate = self
        thePicker.dataSource = self
        txtType.inputView = thePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtType.inputAccessoryView = toolBar
        self.thePicker.reloadAllComponents()
    }
    @objc func doneClick() {
        txtType.resignFirstResponder()
    }
    @objc func cancelClick() {
        txtType.resignFirstResponder()
    }
    
    func showDatePicker(){
       
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        
    }
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
extension AddlogViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtType.text =  types[row]
    }
    
}
