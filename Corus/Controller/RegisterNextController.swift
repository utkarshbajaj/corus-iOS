//
//  RegisterNextController.swift
//  Corus
//
//  Created by Utkarsh on 15/03/21.
//  Copyright © 2021 Utkarsh. All rights reserved.
//

import UIKit
import Firebase

class RegisterNextController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var cityTextfield: UITextField!
    
    @IBOutlet weak var datePicked: UIDatePicker!
    
    let genderData = ["Male", "Female", "Non-binary", "Other"]
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
        
    @objc func donedatePicker() -> String {

      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      return formatter.string(from: datePicked.date)
        
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        
        if let newname = nameTextfield.text, let email = Auth.auth().currentUser?.email, let mycity = cityTextfield.text {
            db.collection(email).addDocument(data: [
                "name" : newname,
                "gender" : genderData[genderPicker.selectedRow(inComponent: 0)],
                "city" : mycity,
                "dob" : donedatePicker()
            ]) { (error) in
                if let e = error {
                    print("Error saving data %@", e)
                } else {
                    print("Data saved successfully")
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                }
            }
        }
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


