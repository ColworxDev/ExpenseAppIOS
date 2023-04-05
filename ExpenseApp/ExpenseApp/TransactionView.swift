//
//  TransactionView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 01/04/2023.
//

import SwiftUI

struct TransactionView: View {
    
    @State private var presentAlert = false
    @State private var isEditing = false
    @State private var isDeleting = false
    
    @State private var spendingTitle: String = ""
    @State private var spendingAmount: String = ""
    @State private var selectedTitle = ""
    @State private var isVisible = true
    let height: CGFloat = 100
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            CustomNavigationView(title: Singleton.getCurrentMonthTitle()) {
                spendingTitle = ""
                spendingAmount = ""
                presentAlert.toggle()
            }
            
            Text("Total " + Singleton.getBalance())
                .padding(.horizontal)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Singleton.shared.transactions) { card in
                        if isVisible {
                            CardView(title: card.display, onEditTapped: {
                                selectedTitle = card.title
                                spendingTitle = card.title
                                spendingAmount = String(card.amount)
                                
                                isEditing.toggle()
                                presentAlert.toggle()
                            }, onDeleteTapped: {
                                Singleton.removeTemplate(card, type: .transaction)
                                refreshData()
                            }, onItemTapped: {
                                //presentAlert.toggle()
                            })
                            .frame(height: height)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .refreshable {
            refreshData()
        }
        .onAppear {
            refreshData()
            Singleton.synchronize()
        }
        .alert("Add", isPresented: $presentAlert, actions: {
                    // Any view other than Button would be ignored
                    TextField("Title", text: $spendingTitle)
                    TextField("Amount", text: $spendingAmount)
                    .keyboardType(.decimalPad)
            
                    Button("Add") {
                        let item = TransactionItem(title: spendingTitle, amount: spendingAmount)
                        if isEditing {
                            Singleton.replaceTransaction(selectedTitle ,item: item, type: .transaction)
                        } else if isDeleting {
                            Singleton.removeTemplate(item, type: .transaction)
                        } else {
                            Singleton.addTransaction(item, type: .transaction)
                        }
                        
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

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
