//
//  SplitInfo.swift
//  SplitApp
//
//  Created by Aanya Jhaveri on 7/3/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

class ToPay { //class to store who owes who and how much
    var whoPays: String
    var howMuch: Double
    var toWhom: String
    
    required init(whoPays: String, howMuch: Double, toWhom: String) {
        self.whoPays = whoPays
        self.howMuch = howMuch
        self.toWhom = toWhom
    }
}

let toPay = ToPay.self //initialize class function for us
