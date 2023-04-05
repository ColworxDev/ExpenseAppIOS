//
//  ContentView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 01/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var activeTab = 0
    var body: some View {
        TabView(selection: $activeTab) {
            TransactionView()
                .tabItem {
                    Label("Transaction", systemImage: "dollarsign")
                }
                .tag(0)
            
            TemplateView(selectedTab: $activeTab)
                .tabItem {
                    Label("Template", systemImage: "lightbulb")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(2)
            
            SavingView()
                .tabItem {
                    Label("Savings", systemImage: "star")
                }
                .tag(3)
        }.onAppear {
            Singleton.shared.getAllData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
