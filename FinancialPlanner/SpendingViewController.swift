//
//  SpendingViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/7/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class SpendingViewController: UIViewController {
    var user: Profile!
    var ref: DatabaseReference!
    @IBOutlet weak var rMaxVal: UILabel!
    @IBOutlet weak var tMaxVal: UILabel!
    @IBOutlet weak var eMaxVal: UILabel!
    @IBOutlet weak var gMaxVal: UILabel!
    @IBOutlet weak var sliderR: UISlider!
    @IBOutlet weak var sliderT: UISlider!
    @IBOutlet weak var sliderE: UISlider!
    @IBOutlet weak var sliderG: UISlider!
    @IBOutlet weak var currentMonthTextField: UILabel!
    @IBOutlet weak var resturauntsLabel: UILabel!
    @IBOutlet weak var groceryLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        currentMonthTextField.text = nameOfMonth
        sliderR.value = Float(user.spentR)
        sliderG.value = Float(user.spentG)
        sliderT.value = Float(user.spentT)
        sliderE.value = Float(user.spentE)
        
        sliderR.maximumValue = Float(user.budgetR)
        sliderE.maximumValue = Float(user.budgetE)
        sliderT.maximumValue = Float(user.budgetT)
        sliderG.maximumValue = Float(user.budgetG)
        
        rMaxVal.text = String(user.budgetR)
        eMaxVal.text = String(user.budgetE)
        tMaxVal.text = String(user.budgetT)
        gMaxVal.text = String(user.budgetG)
        
        resturauntsLabel.text = "\(sliderR.value)"
        groceryLabel.text = "\(sliderG.value)"
        transportationLabel.text = "\(sliderT.value)"
        educationLabel.text = "\(sliderE.value)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func grocerySliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        groceryLabel.text = "\(currentValue)"
        user.spentG = currentValue
        //update spending in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/spentG": self.user.spentG]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func educationSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        educationLabel.text = "\(currentValue)"
        user.spentE = currentValue
        //update spending in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/spentE": self.user.spentE]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func transpoSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        transportationLabel.text = "\(currentValue)"
        user.spentT = currentValue
        //update spending in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/spentT": self.user.spentT]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    @IBAction func resturauntsSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        resturauntsLabel.text = "\(currentValue)"
        user.spentR = currentValue
        //update spending in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/spentR": self.user.spentR]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ProfileViewController){
            let profileView = segue.destination as! ProfileViewController
            profileView.user = self.user
        } else if (segue.destination is BudgetViewController){
            let budgetView = segue.destination as! BudgetViewController
            budgetView.user = self.user
        } else if (segue.destination is TransactionViewController){
            let transactionView = segue.destination as! TransactionViewController
            transactionView.user = self.user
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
