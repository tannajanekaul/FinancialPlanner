//
//  ViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/6/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var user: Profile!
    var ref: DatabaseReference!
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func signUpButtonPress(_ sender: Any) {
        ref = Database.database().reference()
        Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: { (authData, error)  in
            if error == nil {
                self.user = Profile(name: self.usernameTextField.text!,budgetG: 500, budgetE: 1000, budgetT: 100, budgetR: 100, spentG: 0, spentE: 0, spentT: 0, spentR: 0, earned: 0, transactions: "")
        
                let userId = Auth.auth().currentUser!.uid
                self.ref.child("users/\(userId)/username").setValue(self.user.name)
                self.ref.child("users/\(userId)/budgetG").setValue(self.user.budgetG)
                self.ref.child("users/\(userId)/budgetE").setValue(self.user.budgetE)
                self.ref.child("users/\(userId)/budgetT").setValue(self.user.budgetT)
                self.ref.child("users/\(userId)/budgetR").setValue(self.user.budgetR)
                self.ref.child("users/\(userId)/spentG").setValue(self.user.spentG)
                self.ref.child("users/\(userId)/spentE").setValue(self.user.spentE)
                self.ref.child("users/\(userId)/spentT").setValue(self.user.spentT)
                self.ref.child("users/\(userId)/spentR").setValue(self.user.spentR)
                self.ref.child("users/\(userId)/earned").setValue(self.user.earned)
                self.ref.child("users/\(userId)/transactions").setValue(self.user.transactions)
                let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
                self.present(loginView, animated: true, completion: nil)
                //self.navigationController?.pushViewController(loginView, animated: true)
                
            }else{
                //print(error!.localizedDescription)
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

