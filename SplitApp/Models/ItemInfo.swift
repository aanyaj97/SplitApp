//
//  ItemInfo.swift
//  SplitApp
//
//  Created by Aanya Jhaveri on 7/3/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

class ItemPaid { //class to store information about items purchased, and who purchased them
    var title: String
    var amount: Double
    var paidBy: String
    
    required init(title: String, amount: Double, paidBy: String) {
        self.title = title
        self.amount = amount
        self.paidBy = paidBy
    }
}

let itemPaid = ItemPaid.self //initialize class structure for use


