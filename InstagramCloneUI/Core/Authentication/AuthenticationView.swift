//
//  AuthenticationView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 9.10.2023.
//

import SwiftUI

struct AuthenticationView: View {
  var colorScheme: ColorScheme
  @State var isPresented = false
    var body: some View {
      VStack{
        Button {
          isPresented = true
        } label: {
          Text("Login")
        }
      }.fullScreenCover(isPresented: $isPresented) {
        BottomTabBar_()
      }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
      AuthenticationView(colorScheme: .light)
    }
}
