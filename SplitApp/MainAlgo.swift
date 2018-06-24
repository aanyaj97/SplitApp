//
//  MainAlgo.swift
//  SplitApp
//
//  Created by Aanya Jhaveri on 6/23/18.
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

var items: [ItemPaid] = [] //store items purchased
var names: [String] = [] //store names of people

let itemPaid = ItemPaid.self //initialize class structure for use
let toPay = ToPay.self //""

func sum(items: [ItemPaid]) -> Double { //compute total expenditure
    var total = 0.0
    for i in items {
        total += i.amount
    }
    return total
}

func share(people: [String], total: Double) -> Double { //divide expenditure amongst number of people involved
    let share = total/(Double(people.count))
    return Double(share)
}

func paidFor(people: [String], items: [ItemPaid]) -> [String: Double] { //sum up how much each person has already paid for items
    var totalPP: [String: Double] = [:]
    for i in people {
        var paidAlready = 0.0
        for j in items {
            if j.paidBy == i {
                paidAlready += j.amount
            }
        }
        totalPP[i] = paidAlready
    }
    return totalPP
}

func isOwed(paidAlready: [String:Double],share: Double) -> ([String: Double], [String: Double]) { //sum up how off from the even split each person is
    var isOwed: [String: Double] = [:]
    var owes: [String: Double] = [:]
    for i in paidAlready {
        let dif = share - i.value
        if dif < 0 {
            isOwed[i.key] = dif
        } else {
            owes[i.key] = dif
        }
    }
    return (isOwed,owes)
}





//test

var one = itemPaid.init(title: "Uber", amount: 16.73, paidBy: "Aanya")
var two = itemPaid.init(title: "Dinner", amount: 54.24, paidBy: "Joe")
var three = itemPaid.init(title: "Drinks", amount: 88.17, paidBy: "Jacob")
var four = itemPaid.init(title: "Uber", amount: 11.12, paidBy: "Aanya")

names = ["Aanya", "Jacob", "Joe", "Claire","Frank","Bill","Charlie"]

items = [one, two, three, four]

var total = sum(items: items)
var portion = share(people: names, total: total)
var paidAlready = paidFor(people: names, items: items)
var overUnder = isOwed(paidAlready: paidAlready, share: portion)
var over : [(name: String, amount:Double)] = []
var under : [(name: String, amount:Double)] = []



for i in overUnder.0 {
    over.append((i.key,(i.value*(-1))))
}
for i in overUnder.1 {
    under.append((i.key,i.value))
}

var overSorted = over.sorted(by: {$0.amount > $1.amount})
var underSorted = under.sorted(by: {$0.amount > $1.amount})

var resolution : [ToPay] = []


for i in 0...(underSorted.count-1) {
    for j in 0...(overSorted.count-1) {
        if underSorted[i].amount <= overSorted[j].amount {
            resolution.append(toPay.init(whoPays: underSorted[i].name, howMuch: underSorted[i].amount, toWhom: overSorted[j].name))
            overSorted[j].amount = overSorted[j].amount - underSorted[i].amount
            underSorted[i].amount = 0
        }
        if underSorted[i].amount > overSorted[j].amount {
            resolution.append(toPay.init(whoPays: underSorted[i].name, howMuch: overSorted[j].amount, toWhom: overSorted[j].name))
            underSorted[i].amount = underSorted[i].amount - overSorted[j].amount
            overSorted[j].amount = 0
        }
    }
}

for i in 0...(resolution.count - 1) {
    if resolution[i].howMuch != 0.0 {
        print("\(resolution[i].whoPays) pays $\(resolution[i].howMuch) to \(resolution[i].toWhom)")
    }
}


//convert into master function
//create separate pages for class structures
