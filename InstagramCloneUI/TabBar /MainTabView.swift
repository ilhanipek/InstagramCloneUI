//
//  MainTabView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
      TabView {
        HomeView().tabItem {
          Image(systemName: "house.fill")
        }
      }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
