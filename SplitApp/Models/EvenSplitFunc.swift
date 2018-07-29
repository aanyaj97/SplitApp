//
//  EvenSplitFunc.swift
//  SplitApp
//
//  Created by Aanya Jhaveri on 7/3/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

func evenSplit(items: [ItemPaid], people: [String]) -> [ToPay] {
    var resolution : [ToPay] = []
    let total = sum(items: items)
    let piece = share(people: people, total: total)
    let paidAlready = paidFor(people: people, items: items)
    let overUnder = isOwed(paidAlready: paidAlready, share: piece)
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
    return resolution
}


//functions that make up super function in case individual factors are needed for UI

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



