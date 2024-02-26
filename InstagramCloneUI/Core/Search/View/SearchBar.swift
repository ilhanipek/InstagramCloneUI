//
//  SearchBar.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.12.2023.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.leading, 24)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onTapGesture {
                  withAnimation(.spring) {
                    isSearching = true
                  }
                }

            if isSearching {
                Button(action: {
                    text = ""
                  withAnimation(.spring) {
                    isSearching = false
                  }
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("return")
                        .padding(.trailing, 8)
                        .foregroundStyle(Color.blue)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 20, alignment: .center)
    }
}

#Preview {
  SearchBar(text: .constant(""), isSearching: .constant(false))
}
