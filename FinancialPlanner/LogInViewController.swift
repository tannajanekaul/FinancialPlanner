//
//  LogInViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/7/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var user: Profile!
    var ref: DatabaseReference!
    
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPress(_ sender: Any) {
        ref = Database.database().reference()
        Auth.auth().signIn(withEmail: loginUsername.text!, password: loginPassword.text!) { (userData, error) in
            if error == nil{
                //user signed in
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let username = value?["username"] as? String ?? ""
                    let budgetG = value?["budgetG"] as? Int
                    let budgetE = value?["budgetE"] as? Int
                    let budgetT = value?["budgetT"] as? Int
                    let budgetR = value?["budgetR"] as? Int
                    let spentG = value?["spentG"] as? Int
                    let spentE = value?["spentE"] as? Int
                    let spentT = value?["spentT"] as? Int
                    let spentR = value?["spentR"] as? Int
                    let earned = value?["earned"] as? Int
                    let transactions = value?["transactions"] as? String ?? ""
                    
                    self.user = Profile(name: username,budgetG: budgetG!, budgetE: budgetE!, budgetT: budgetT!, budgetR: budgetR!, spentG: spentG!, spentE: spentE!, spentT: spentT!, spentR: spentR!,earned: earned!, transactions: transactions)
                    
                    let profileView = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    profileView.user = self.user
                    
                    self.present(profileView, animated: true, completion: nil)
                }) { (error) in
                    print(error.localizedDescription)
                }
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
