//
//  RegisterController.swift
//  Corus
//
//  Created by Utkarsh on 15/03/21.
//  Copyright © 2021 Utkarsh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

//    
//    @IBOutlet weak var genderPicker: UIPickerView!
//
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // [START_EXCLUDE]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      // [START remove_auth_listener]
      Auth.auth().removeStateDidChangeListener(handle!)
      // [END remove_auth_listener]
    }

    
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var newpasswd: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if passwd.text != newpasswd.text {
            let alert = UIAlertController(title: "Error", message: "Passwords do not match!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: passwd.text!) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print(error!.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.performSegue(withIdentifier: "regNext", sender: self)
                print("\(user.email!) created")
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
