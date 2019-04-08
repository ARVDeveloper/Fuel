//
//  ADDVehicleViewController.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit
import MaterialComponents
class ADDVehicleViewController: UIViewController {

    @IBOutlet weak var txtName: MDCTextField!
    @IBOutlet weak var txtNumber: MDCTextField!
    @IBOutlet weak var txtType: MDCTextField!
    @IBOutlet weak var currentMeter: MDCTextField!
    let thePicker = UIPickerView()
    var types = ["Bike","Car","Bus"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let vModel = VehicleModel()
        vModel.id =  "\(Int(CACurrentMediaTime()))"
        vModel.name = txtName.text!
        vModel.number = txtNumber.text!
        vModel.name = txtName.text!
        vModel.odometer = currentMeter.text!
        vModel.saveData(vehicle: vModel)
        self.navigationController?.popViewController(animated: true)
        self.showalert(message: "Vehicle add Succesfully.", title: "Succes")
    }
    
}
extension UIViewController{
    func showalert(message:String,title:String){
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
   
    }
}
extension ADDVehicleViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
