//
//  TransactionViewController.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/7/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import UIKit
import Firebase

class TransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var picker: UIPickerView!
    var user: Profile!
    var pickerData: [String] = [String]()
    var category: String!
    var ref: DatabaseReference!
    var dict = [String : Int]()
    
    @IBOutlet weak var transactionTextView: UITextView!
    @IBOutlet weak var transactionAmount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Education","Resturaunt","Groceries","Transportation"]
        category = "Education"
        dict["Education"] = 0
        dict["Resturaunt"] = 1
        dict["Groceries"] = 2
        dict["Transportation"] = 3
        // Do any additional setup after loading the view.
        var transactionArray = user.transactions.split(separator:"x")
        for var transaction in transactionArray {
            //get category
            let categoryIndex = Int(String(transaction.first!))
            var categoryString = ""
            for (key, val) in dict {
                if (val == categoryIndex) {
                    categoryString = key
                }
            }
            transaction.removeFirst()
            let amountString = transaction
            //update transaction text view
            transactionTextView.text = categoryString + " Spent: " + String(amountString) + "\n" + transactionTextView.text!
            //transactionTextView.text = transactionTextView.text! + "\n"
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTransaction(_ sender: Any) {
        ref = Database.database().reference()
        transactionTextView.text = category + " Spent: " + transactionAmount.text! + "\n" + transactionTextView.text
      //  transactionTextView.text = transactionTextView.text + "\n"
        if (category == "Resturaunt") {
            user.spentR = Int(transactionAmount.text!)!
            var transactionString = ""
            transactionString += String(describing: dict["Resturaunt"]!)
            transactionString += transactionAmount.text!
            transactionString += "x"
            
            user.transactions += transactionString
            //update spending in database
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                //update the value in the database
                let childUpdates0 = ["/users/" + userID! + "/transactions": self.user.transactions]
                let childUpdates = ["/users/" + userID! + "/spentR": self.user.spentR]
                self.ref.updateChildValues(childUpdates)
                self.ref.updateChildValues(childUpdates0)
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if (category == "Education") {
            user.spentE = Int(transactionAmount.text!)!
            var transactionString = ""
            transactionString += String(describing: dict["Education"]!)
            transactionString += transactionAmount.text!
            transactionString += "x"
            
            user.transactions += transactionString
            //update spending in database
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                //update the value in the database
                let childUpdates0 = ["/users/" + userID! + "/transactions": self.user.transactions]
                self.ref.updateChildValues(childUpdates0)
                let childUpdates = ["/users/" + userID! + "/spentE": self.user.spentE]
                self.ref.updateChildValues(childUpdates)
            }) { (error) in
                print(error.localizedDescription)
            }
        }else if (category == "Groceries") {
            user.spentG = Int(transactionAmount.text!)!
            var transactionString = ""
            transactionString += String(describing: dict["Groceries"]!)
            transactionString += transactionAmount.text!
            transactionString += "x"
            
            user.transactions += transactionString
            //update spending in database
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                //update the value in the database
                let childUpdates0 = ["/users/" + userID! + "/transactions": self.user.transactions]
                self.ref.updateChildValues(childUpdates0)
                let childUpdates = ["/users/" + userID! + "/spentG": self.user.spentG]
                self.ref.updateChildValues(childUpdates)
            }) { (error) in
                print(error.localizedDescription)
            }
        } else if (category == "Transportation") {
            user.spentT = Int(transactionAmount.text!)!
            var transactionString = ""
            transactionString += String(describing: dict["Transportation"]!)
            transactionString += transactionAmount.text!
            transactionString += "x"
            
            user.transactions += transactionString
            //update spending in database
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                //update the value in the database
                let childUpdates0 = ["/users/" + userID! + "/transactions": self.user.transactions]
                self.ref.updateChildValues(childUpdates0)
                let childUpdates = ["/users/" + userID! + "/spentT": self.user.spentT]
                self.ref.updateChildValues(childUpdates)
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            //this is bad, do something
        }
//        let spendingView = self.storyboard?.instantiateViewController(withIdentifier: "SpendingViewController") as! SpendingViewController
//        spendingView.user = self.user
//        self.present(spendingView, animated: true, completion: nil)
    }
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
       // numShares = row+1
        category = pickerData[row]
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
        } else if (segue.destination is SpendingViewController){
            let spendingView = segue.destination as! SpendingViewController
            spendingView.user = self.user
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
