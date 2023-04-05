//
//  TemplateView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import SwiftUI

struct TemplateView: View {
    
    @State private var presentAlert = false
    @State private var isEditing = false
    @State private var spendingTitle: String = ""
    @State private var spendingAmount: String = ""
    @State private var isDataRefreshed: Bool = false
    @State private var selectedTitle = ""
    @State private var isVisible = true
    @Binding var selectedTab: Int
    
    let height: CGFloat = 100
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            CustomNavigationView(title: "Template") {
                spendingTitle = ""
                spendingAmount = ""
                presentAlert.toggle()
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Singleton.shared.templateTransaction) { card in
                        if isVisible {
                            CardView(title: card.display, onEditTapped: {
                                selectedTitle = card.title
                                spendingTitle = card.title
                                spendingAmount = String(card.amount)
                                isEditing.toggle()
                                presentAlert.toggle()
                            }, onDeleteTapped: {
                                Singleton.removeTemplate(card, type: .template)
                                refreshData()
                            }, onItemTapped: {
                                selectedTab = 0
                                Singleton.addTransaction(card, type: .transaction)
                            })
                            .frame(height: height)
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }.alert("Add", isPresented: $presentAlert, actions: {
            // Any view other than Button would be ignored
            TextField("Title", text: $spendingTitle)
            TextField("Amount", text: $spendingAmount)
                .keyboardType(.decimalPad)
    
            Button("Add") {
                let item = TransactionItem(title: spendingTitle, amount: spendingAmount)
                if isEditing {
                    Singleton.replaceTransaction(selectedTitle, item: item, type: .template)
                } else {
                    Singleton.addTransaction(item, type: .template)
                }
                
                presentAlert = false
                isEditing = false
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

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(selectedTab: .constant(1))
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
