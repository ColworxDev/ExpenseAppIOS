//
//  UserDefaultHelper.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import Foundation

struct UserDefaultHelper {
    @UserDefault(key: "transactions", defaultValue: "")
    static var transactions
    
    @UserDefault(key: "template", defaultValue: "")
    static var template
    
    @UserDefault(key: "history", defaultValue: "")
    static var history
    
    @UserDefault(key: "savings", defaultValue: "")
    static var savings
}



@propertyWrapper
fileprivate struct UserDefault<T: Codable> {
    fileprivate let key: String
    fileprivate let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
