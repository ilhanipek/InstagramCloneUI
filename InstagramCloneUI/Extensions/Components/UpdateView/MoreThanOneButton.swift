//
//  MoreThanOneButton.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 31.10.2023.
//

import SwiftUI

struct MoreThanOneButton: View {
  @Binding var isMoreThanOne : Bool
  @Binding var isMoreThanOneIcon : Bool
  @Binding var isMoreThanOneActive : Bool
    var body: some View {
      
      VStack {
        Button {
          withAnimation(.linear) {
            isMoreThanOne.toggle()
          }
          withAnimation(.linear) {
            isMoreThanOneIcon.toggle()
          }
          isMoreThanOneActive.toggle()
        } label: {
          Text(isMoreThanOne ? "\(Image(systemName: "square.on.square"))  Select more than one photo" : "\(Image(systemName: "square")) Select one photo")
          .foregroundStyle(Color.themes.customAccent2)
          .background {
            RoundedRectangle(cornerRadius: 10).frame(width: isMoreThanOneIcon ? 165 : 250 ,height: 40,alignment: .center).foregroundStyle(Color.themes.customAccent)
          }

      }
      }


    }
}

#Preview {
  MoreThanOneButton(isMoreThanOne: .constant(true), isMoreThanOneIcon: .constant(false), isMoreThanOneActive: .constant(false))
}
