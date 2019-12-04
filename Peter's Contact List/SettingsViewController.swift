//
//  SettingsViewController.swift
//  Peter's Contact List
//
//  Created by Peter Kim on 11/6/19.
//  Copyright © 2019 Peter Kim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pckSortField: UIPickerView!
    @IBOutlet weak var swAscending: UISwitch!
    @IBOutlet weak var lblBattery: UILabel!
    
    
    let sortOrderItems: Array<String> = ["contactName", "city", "birthday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pckSortField.dataSource = self
        pckSortField.delegate = self
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.batteryChanged),
                                               name: UIDevice.batteryStateDidChangeNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.batteryChanged),
                                               name: UIDevice.batteryLevelDidChangeNotification,
                                               object: nil)
        self.batteryChanged()

        
    }
    
    @objc func batteryChanged(){
        
        let device = UIDevice.current
        var batteryState: String
        
        switch(device.batteryState){
            case .charging:
                batteryState = "+"
            case .full:
                batteryState = "!"
            case .unplugged:
                batteryState = "-"
            case .unknown:
                batteryState = "?"
            
        }
        
        let batteryLevelPercent = device.batteryLevel * 100
        let batteryLevel = String(format: "%.0f%%", batteryLevelPercent)
        let batteryStatus = "\(batteryLevel) (\(batteryState))"
        lblBattery.text = batteryStatus
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set the UI based on values in UserDefaults
        
        let settings = UserDefaults.standard
        swAscending.setOn(settings.bool(forKey: Constants.kSortDirectionAscending), animated: true)
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in sortOrderItems {
            if field == sortField {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        
        pckSortField.reloadComponent(0)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let device = UIDevice.current
        print("Device Info:")
        print("Name: \(device.name)") // Device Name
        print("Model: \(device.model)") // Device Model such as iPhone/iPad
        print("System Name: \(device.systemName)") // OS, such as iPhone OS
        print("System Version: \(device.systemVersion)") // OS Version Number
        print("Identifier: \(device.identifierForVendor!)") // Unique App Device Identifier
        
        let orientation: String
        switch device.orientation {
            case .faceDown:
                orientation = "Face Down"
            case .landscapeLeft:
                orientation = "Landscape Left"
            case .portrait:
                orientation = "Portrait"
            case .landscapeRight:
                orientation = "Landscape Right"
            case .faceUp:
                orientation = "Face Up"
            case .portraitUpsideDown:
                orientation = "Portrait Upside Down"
            case .unknown:
                orientation = "Unknown Orientation"
        }
        print("Orientation: \(orientation)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()
    }
    
    //Returns the number of 'columns' to display
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Returns the # of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
    }
    
    //Sets the value that is shown for each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOrderItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
//        print("Chosen item: \(sortOrderItems[row])")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
