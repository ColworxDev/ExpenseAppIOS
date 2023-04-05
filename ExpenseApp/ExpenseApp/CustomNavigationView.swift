//
//  CustomNavigationView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import SwiftUI

struct CustomNavigationView: View {
    let title: String
    var onTap: (()->Void)?
    var body: some View {
        HStack {
            Spacer()
            
            Text(title)
            
            Spacer()
            
            if let onTap = onTap {
                Button("+") {
                    onTap()
                }
                .frame(width: 40)
            }
            
                
        }
        .font(Font.largeTitle)
        .padding(.horizontal, 20)
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView.init(title: "Testing")
    }
}
