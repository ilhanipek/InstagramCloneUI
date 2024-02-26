//
//  MainView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 14.10.2023.
//

import SwiftUI

struct MainView: View {
  @StateObject var mainViewModel = MainViewModel()
  @Environment (\.colorScheme) var colorScheme
  @ObservedObject var registrationViewModel = RegistrationViewModel()
  
    var body: some View {
      Group {
        if mainViewModel.userSession == nil {
          LoginView()
            .environmentObject(registrationViewModel)
        }else if let currentUser = mainViewModel.currentUser {
          BottomTabBarView(user: currentUser)
        }
      }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
