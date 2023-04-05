//
//  Singleton.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import Foundation
import SwiftUI

struct TransactionItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let amount: Double
    
    init(title: String, amount: String) {
        self.title = title
        self.amount = Double(amount) ?? 0
    }
    
    var display: String {
        return String(amount) + ": " + title
    }
    
}

struct MonthlyTransactionItem: Codable, Identifiable {
    var id = UUID()
    var month: String
    var transactions: [TransactionItem]
}

enum TRX_TYPE {
    case transaction
    case template
    case savings
}

class Singleton {
    private init() {
    }
    
    static let shared = Singleton()
    
    
    
    
    
    @Published var monthlyTransactions: [MonthlyTransactionItem] = []
    
    
    
    @Published var savings: [TransactionItem] = [
        TransactionItem(title: "Bank 1", amount: "0"),
        TransactionItem(title: "Bank 2", amount: "32"),
        TransactionItem(title: "Bank 3", amount: "0"),
        TransactionItem(title: "Bank 4", amount: "0"),
        TransactionItem(title: "Bank 5", amount: "10")
    ]
    
    @Published var templateTransaction: [TransactionItem] = [
        TransactionItem(title: "Rent", amount: "800"),
        TransactionItem(title: "Wifi", amount: "32"),
        TransactionItem(title: "Electricity", amount: "70"),
        TransactionItem(title: "Mobile Topup", amount: "7"),
        TransactionItem(title: "Mobile Wife", amount: "10")

    ]
    
    @Published var transactions: [TransactionItem] = [
        TransactionItem(title: "Rent", amount: "800"),
        TransactionItem(title: "Wifi", amount: "32")
    ]
    
    func getAllData() {
        let jsonDecoder = JSONDecoder()
        do {
            if UserDefaultHelper.transactions != "" {
                let jsonStr = UserDefaultHelper.transactions
                if let jsonData = jsonStr.data(using: .utf8) {
                    Singleton.shared.transactions = try jsonDecoder.decode([TransactionItem].self, from: jsonData)
                }
            }
            
            if UserDefaultHelper.savings != "" {
                let jsonStr = UserDefaultHelper.savings
                if let jsonData = jsonStr.data(using: .utf8) {
                    Singleton.shared.savings = try jsonDecoder.decode([TransactionItem].self, from: jsonData)
                }
            }
            
            if UserDefaultHelper.template != "" {
                let jsonStr = UserDefaultHelper.template
                if let jsonData = jsonStr.data(using: .utf8) {
                    Singleton.shared.templateTransaction = try jsonDecoder.decode([TransactionItem].self, from: jsonData)
                }
            }
            
            if UserDefaultHelper.history != "" {
                let jsonStr = UserDefaultHelper.history
                if let jsonData = jsonStr.data(using: .utf8) {
                    Singleton.shared.monthlyTransactions = try jsonDecoder.decode([MonthlyTransactionItem].self, from: jsonData)
                }
            }
        } catch {
            print(error)
        }
    }
    
    static func synchronize() {
        if let json = getJson(item: shared.transactions) {
            UserDefaultHelper.transactions = json
        }
        
        if let json = getJson(item: shared.templateTransaction) {
            UserDefaultHelper.template = json
        }
        
        if let json = getJson(item: shared.monthlyTransactions) {
            UserDefaultHelper.history = json
        }
        
        if let json = getJson(item: shared.savings) {
            UserDefaultHelper.savings = json
        }
        
        func getJson(item: Codable) -> String? {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(item)
                return String(data: jsonData, encoding: String.Encoding.utf8)
            } catch {
                print(error)
            }
            return nil
        }
    }
    
    static func getCurrentMonthTitle() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }
    
    static func addHistorySpendings() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let dateStr = dateFormatter.string(from: Date())
        shared.monthlyTransactions.removeAll {
            $0.month.hasPrefix(dateStr)
        }
        shared.monthlyTransactions.append(MonthlyTransactionItem(month: dateStr + ":  Spending: " + getBalance(), transactions: shared.transactions))
    }
    
    
    //Replace Transaction
    static func replaceTransaction(_ title: String, item: TransactionItem, type: TRX_TYPE) {
        if type == .transaction {
            for (index, item2) in shared.transactions.enumerated() {
                    if item2.title == title {
                        shared.transactions[index] = item
                }
            }
        } else if type == .template {
            for (index, item2) in shared.templateTransaction.enumerated() {
                if item2.title == title {
                    shared.templateTransaction[index] = item
                }
            }
        } else {
            for (index, item2) in shared.savings.enumerated() {
                if item2.title == title {
                    shared.savings[index] = item
                }
            }
        }
    }
    
    
    
    //Add Transaction
    static func addTransaction(_ item: TransactionItem, type: TRX_TYPE) {
        if containsItem(item: item, type: type) { return }
        if type == .transaction {
            shared.transactions.append(item)
        } else if type == .template {
            shared.templateTransaction.append(item)
        } else {
            shared.savings.append(item)
        }
        
    }
    
    //contains item
    private static func containsItem(item: TransactionItem, type: TRX_TYPE) -> Bool {
        if type == .template {
            return shared.templateTransaction.filter { item2 in
                item.title == item2.title
            }.count > 0
        } else if type == .transaction {
            return shared.transactions.filter { item2 in
                item.title == item2.title
            }.count > 0
        } else {
            return shared.savings.filter { item2 in
                item.title == item2.title
            }.count > 0
        }
    }
    
    //contains Transaction
    static func removeTemplate(_ item: TransactionItem, type: TRX_TYPE) {
        if type == .transaction {
            shared.transactions.removeAll { item1 in
                item1.title == item.title
            }
        } else if type == .savings {
            shared.savings.removeAll { item1 in
                item1.title == item.title
            }
        } else {
            shared.templateTransaction.removeAll { item1 in
                item1.title == item.title
            }
        }
        
    }
    
    static func getBalance() -> String {
        var amount: Double = 0
        shared.transactions.forEach { item in
            amount += item.amount
        }
        return String(amount)
    }
}
