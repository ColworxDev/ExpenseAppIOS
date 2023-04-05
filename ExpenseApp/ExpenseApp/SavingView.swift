//
//  SavingView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 01/04/2023.
//

import SwiftUI

struct SavingView: View {
    let height: CGFloat = 100
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var presentAlert = false
    @State private var isEditing = false
    @State private var isDeleting = false
    @State private var spendingTitle: String = ""
    @State private var spendingAmount: String = ""
    @State private var selectedTitle = ""
    @State private var isVisible = true
    
    var body: some View {
        VStack(alignment: .leading) {
            
            CustomNavigationView(title: "Savings")
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Singleton.shared.savings) { card in
                    if isVisible {
                        CardView(title: card.display, onEditTapped: {
                            selectedTitle = card.title
                            spendingTitle = selectedTitle
                            spendingAmount = String(card.amount)
                            isEditing.toggle()
                            presentAlert.toggle()
                        }, onDeleteTapped: {
                            //Singleton.removeTemplate(card, type: .savings)
                            refreshData()
                        }, onItemTapped: {
                            //presentAlert.toggle()
                        })
                        .frame(height: height)
                    }
                }
            }.padding()
            
            Spacer()
        }
        .alert("Add", isPresented: $presentAlert, actions: {
            // Any view other than Button would be ignored
            TextField("Title", text: $spendingTitle)
            TextField("Amount", text: $spendingAmount)
                .keyboardType(.decimalPad)
    
            Button("Add") {
                let item = TransactionItem(title: spendingTitle, amount: spendingAmount)
                Singleton.replaceTransaction(selectedTitle ,item: item, type: .savings)
                
                
                presentAlert = false
                isEditing = false
                isDeleting = false
            }
    
            Button("Cancel", role: .cancel) { }
        }, message: {
            // Any view other than Text would be ignored
            Text("Add spending")
        })
    }
    
    func refreshData() {
        isVisible.toggle()
        isVisible.toggle()
    }
}

struct SavingView_Previews: PreviewProvider {
    static var previews: some View {
        SavingView()
    }
}
