//
//  DateViewController.swift
//  Peter's Contact List
//
//  Created by Peter Kim on 11/13/19.
//  Copyright © 2019 Peter Kim. All rights reserved.
//


import UIKit

protocol DateControllerDelegate: class {
    func dateChanged(date: Date)
    
}

class DateViewController: UIViewController {
    //Delegate may not always be set, so it's weak, and the type is option (?)
    //Optional types are set to nil by default - no need for init methods.
    weak var delegate: DateControllerDelegate?
    
    @IBOutlet weak var dtpDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let saveButton: UIBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                            target: self,
                            action: #selector(saveDate))
            
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Your Birthday"
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        self.navigationController?.popViewController(animated: true)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
