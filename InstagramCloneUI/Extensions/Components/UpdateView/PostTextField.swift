//
//  PostTextField.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 1.11.2023.
//

import SwiftUI

struct PostTextField: View {
  @Binding var caption: String
  @Binding var textFieldText : String
  @State var screenWidth : CGFloat = UIScreen.main.bounds.width
  @Binding var isPresented : Bool
    var body: some View {
        TextField(caption, text: $textFieldText, axis: .vertical)
          .tint(Color.themes.customAccent2)

          .background {
            RoundedRectangle(cornerRadius: 8).stroke().frame(width: isPresented ? screenWidth - 20 : 0 ,height: 150,alignment: .center).foregroundStyle(Color.themes.customAccent)
          }
    }
}

#Preview {
  PostTextField(caption: .constant(""), textFieldText: .constant(""), isPresented: .constant(false))
}
