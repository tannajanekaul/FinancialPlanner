//
//  BudgetViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/7/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class BudgetViewController: UIViewController {
    var user: Profile!
    var ref: DatabaseReference!
    @IBOutlet weak var sliderR: UISlider!
    @IBOutlet weak var sliderT: UISlider!
    @IBOutlet weak var sliderG: UISlider!
    @IBOutlet weak var labelR: UILabel!
    @IBOutlet weak var sliderE: UISlider!
    @IBOutlet weak var labelT: UILabel!
    @IBOutlet weak var labelE: UILabel!
    @IBOutlet weak var labelG: UILabel!
    @IBOutlet weak var currentMonthTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        currentMonthTextField.text = nameOfMonth
        sliderR.value = Float(user.budgetR)
        sliderG.value = Float(user.budgetG)
        sliderT.value = Float(user.budgetT)
        sliderE.value = Float(user.budgetE)
        labelR.text = "\(sliderR.value)"
        labelG.text = "\(sliderG.value)"
        labelT.text = "\(sliderT.value)"
        labelE.text = "\(sliderE.value)"
        
        // Do any additional setup after loading the view.
    }

    @IBAction func grocerySliderChanged(_ sender: UISlider)
    {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        user.budgetG = currentValue
        labelG.text = "\(currentValue)"
        //update budget in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/budgetG": self.user.budgetG]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func eduSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        user.budgetE = currentValue
        labelE.text = "\(currentValue)"
        //update budget in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/budgetE": self.user.budgetE]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func transpoSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        user.budgetT = currentValue
        labelT.text = "\(currentValue)"
        //update budget in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/budgetT": self.user.budgetT]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func restSliderChanged(_ sender: UISlider) {
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        user.budgetR = currentValue
        labelR.text = "\(currentValue)"
        //update budget in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/budgetR": self.user.budgetR]
            self.ref.updateChildValues(childUpdates)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is ProfileViewController){
            let profileView = segue.destination as! ProfileViewController
            profileView.user = self.user
        } else if (segue.destination is TransactionViewController){
            let transactionView = segue.destination as! TransactionViewController
            transactionView.user = self.user
        } else if (segue.destination is SpendingViewController){
            let spendingView = segue.destination as! SpendingViewController
            spendingView.user = self.user
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
