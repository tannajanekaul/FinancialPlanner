//
//  ProfileViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/7/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    var user: Profile!
    var ref: DatabaseReference!
    @IBOutlet weak var earnedSlider: UISlider!
    @IBOutlet weak var spentSlider: UISlider!
    @IBOutlet weak var totalBudgetLabel: UILabel!
    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var totalMoneyTextField: UITextField!
    @IBOutlet weak var currentMonthTextField: UITextField!
    @IBOutlet weak var spentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        currentMonthTextField.text = nameOfMonth
        totalMoneyTextField.text = String(user.earned)
        
        totalBudgetLabel.text = String(user.budgetG + user.budgetE + user.budgetT + user.budgetR)
        spentSlider.maximumValue = Float(user.budgetG + user.budgetE + user.budgetT + user.budgetR)
        spentSlider.value = Float(user.spentG + user.spentE + user.spentT + user.spentR)
        earnedLabel.text = String(user.earned)
        earnedSlider.value = Float(user.earned)
        spentLabel.text = String(user.spentG + user.spentE + user.spentT + user.spentR)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func earnedSliderChanged(_ sender: UISlider){
        ref = Database.database().reference()
        let currentValue = Int(sender.value)
        
        earnedLabel.text = "\(currentValue)"
        totalMoneyTextField.text = "\(currentValue)"
        user.earned = currentValue
        //update earned money in database
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //update the value in the database
            let childUpdates = ["/users/" + userID! + "/earned": self.user.earned]
            self.ref.updateChildValues(childUpdates)

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func spentSliderChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        spentLabel.text = "\(currentValue)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is TransactionViewController){
            let transactionView = segue.destination as! TransactionViewController
            transactionView.user = self.user
        } else if (segue.destination is BudgetViewController){
            let budgetView = segue.destination as! BudgetViewController
            budgetView.user = self.user
        } else if (segue.destination is SpendingViewController){
            let spendingView = segue.destination as! SpendingViewController
            spendingView.user = self.user
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
