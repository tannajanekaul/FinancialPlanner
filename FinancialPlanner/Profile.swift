//
//  File.swift
//  FinancialPlanner
//
//  Created by Tanna Jane Quale Kaul on 10/18/18.
//  Copyright © 2018 Tanna Jane Quale Kaul. All rights reserved.
//

import Foundation
import UIKit

class Profile{
    var name: String
    var budgetG: Int
    var budgetE: Int
    var budgetT: Int
    var budgetR: Int
    var spentG: Int
    var spentE: Int
    var spentT: Int
    var spentR: Int
    var earned: Int
    var transactions: String
    init?(name: String, budgetG: Int,budgetE: Int,budgetT: Int,budgetR: Int,spentG: Int,spentE: Int,spentT: Int,spentR: Int, earned: Int, transactions: String){
        if (name.isEmpty){
            return nil
        }
        self.name = name
        self.budgetG = budgetG
        self.budgetE = budgetE
        self.budgetT = budgetT
        self.budgetR = budgetR
        self.spentG = spentG
        self.spentE = spentE
        self.spentT = spentT
        self.spentR = spentR
        self.earned = earned
        self.transactions = transactions
    }
}
