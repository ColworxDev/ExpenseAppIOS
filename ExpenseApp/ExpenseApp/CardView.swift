//
//  CardView.swift
//  ExpenseApp
//
//  Created by Shujat Ali on 02/04/2023.
//

import SwiftUI

struct CardView: View {
    let title: String
    let onEditTapped: (()->Void)
    let onDeleteTapped: (()->Void)
    let onItemTapped: (()->Void)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).foregroundColor(.yellow)
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                Spacer()
                HStack {
                    Button {
                        onEditTapped()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    
                    Spacer()
                    
                    Button {
                        onDeleteTapped()
                    } label: {
                        Image(systemName: "trash")
                    }
                }.padding(.horizontal, 10)
            }.padding(.all, 10)
            
        }.onTapGesture {
            onItemTapped()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "row item") {
            print("edit tapped")
        } onDeleteTapped: {
            print("delete tapped")
        } onItemTapped: {
            print("item tapped")
        }

    }
}
