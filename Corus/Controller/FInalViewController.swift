//
//  FInalViewController.swift
//  Corus
//
//  Created by Utkarsh on 15/03/21.
//  Copyright © 2021 Utkarsh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FInalViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let user = Auth.auth().currentUser
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        emailLabel.text = user?.email
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func fetchPressed(_ sender: UIButton) {
        
        db.collection(emailLabel.text!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let myData = querySnapshot?.documents[0].data()
                    self.nameLabel.text = myData?["name"] as? String ?? ""
                    self.cityLabel.text = myData?["city"] as? String ?? ""
                    self.genderLabel.text = myData?["gender"] as? String ?? ""
                    self.dobLabel.text = myData?["dob"] as? String ?? ""
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }
    //    if let use = user {
//        // The user's ID, unique to the Firebase project.
//        // Do NOT use this value to authenticate with your backend server,
//        // if you have one. Use getTokenWithCompletion:completion: instead.
//        let uid = use.uid
//        let email = use.email
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
