//
//  ExpenseAppApp.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 01/04/2023.
//

import SwiftUI

@main
struct ExpenseAppApp: App {
    @State var isLogin = false
    
    
    var body: some Scene {
        WindowGroup {
            if !isLogin {
                PassView() {
                    isLogin = true
                }
            } else {
                ContentView()
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                                        isLogin = false
                                    }
            }
        }
    }
}
