//
//  ProfileSheet.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 8.10.2023.
//

import SwiftUI

struct ProfileSheet: View {
  @State private var isPresented = false
  @State private var sheetHeight: CGFloat = UIScreen.main.bounds.height / 2
  
  var body: some View {
    VStack {
      Button(action: {
        self.isPresented = true
      }) {
        Text("Sheet Aç")
      }
      .sheet(isPresented: $isPresented) {
        VStack {
          Text("Açılan Sheet İçeriği")
          
          Spacer()
          
          Button("Kapat") {
            isPresented.toggle()
          }
        }
        .frame(maxHeight: sheetHeight)
      }
    }
  }
}

struct ProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSheet()
    }
}
