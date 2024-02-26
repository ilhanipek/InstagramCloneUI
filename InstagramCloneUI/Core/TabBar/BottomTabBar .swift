//
//  BottomTabBar .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct BottomTabBarView: View {
  @Environment (\.colorScheme) var colorScheme
  let user: User
    var body: some View {
      TabView {
        HomeView().tabItem {
          Image(systemName: "house.fill")
        }

        SearchView().tabItem {
          Image(systemName: "magnifyingglass")
        }

        UpdatePostView().tabItem {
          Image(systemName: "plus.square")
        }

        CurrentUserView(user: user).tabItem {
          Image(systemName: "person")
        }
      }.tint(Color.themes.customAccent)
    }
}

struct BottomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
      BottomTabBarView(user: User.users[0])
    }
}
