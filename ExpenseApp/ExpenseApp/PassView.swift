//
//  PassView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import SwiftUI

struct PassView: View {
    @State var password = ""
    let openHome: () -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            CustomNavigationView(title: "Enter PassCode")
            
            SecureField("PassCode", text: $password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)
                .keyboardType(.numberPad)
                .focused($isFocused)
            Button("Submit") {
                if password == "111" {
                    password = ""
                    isFocused = false
                    openHome()
                } else {
                    password = ""
                }
            }
            
            
            Spacer()
        }.padding(.horizontal)
            .onAppear {
                isFocused = true
            }
        
    }
}

struct PassView_Previews: PreviewProvider {
    static var previews: some View {
        PassView() {
            
        }
    }
}
