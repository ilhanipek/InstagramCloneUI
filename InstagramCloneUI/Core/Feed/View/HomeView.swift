//
//  HomeView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct HomeView: View {
  @Environment (\.colorScheme) var colorScheme
  @StateObject var feedViewModel = FeedViewModel.shared

  var body: some View {
    NavigationStack {
      VStack {
        FeedCell2()
      }
      .refreshable {
        Task {
          try await feedViewModel.refreshPosts()
          try await feedViewModel.refreshLikes()
          try await feedViewModel.fetchFeed()
        }
      }
    }
    .navigationTitle("Feed")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      // Instagram Header
      ToolbarItem(placement: .navigationBarLeading) {
        makeInstaLogo(colorScheme: colorScheme, lightImageName: "InstagramLogo", darkImageName: "InstagramFontDarkMode", frameWidth: 90, frameHeight: 80)
      }
      // DM button
      ToolbarItem(placement: .navigationBarTrailing) {
        Image(systemName: "paperplane")
      }
    }
  }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView()
    }
}
