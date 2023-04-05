//
//  HistoryView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 01/04/2023.
//

import SwiftUI

struct HistoryView: View {
    @State private var presentAlert = false
    @State private var isVisible = true
    
    var body: some View {
        VStack(alignment: .leading) {
            
            CustomNavigationView(title: "History") {
                presentAlert.toggle()
            }
            
            List {
                ForEach(Singleton.shared.monthlyTransactions) { item in
                    if isVisible {
                        Section(header: Text(item.month)) {
                            ForEach(item.transactions) { row in
                                Text(row.display)
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }.alert("Add", isPresented: $presentAlert, actions: {
            // Any view other than Button would be ignored
            Text("Confirm save current Spendings")
            
            Button("Add") {
                Singleton.addHistorySpendings()
                isVisible = false
                isVisible = true
                presentAlert = false
            }
            
            Button("Cancel", role: .cancel) { }
        }, message: {
            // Any view other than Text would be ignored
            Text("Add spending")
        })
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
