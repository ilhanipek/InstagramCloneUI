//
//  NavigationStack.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 9.10.2023.
//

import Foundation
import SwiftUI


extension NavigationStack {

  func toolbar() {
    var colorScheme : ColorScheme = .light
    // Instagram Font
    ToolbarItem(placement: .navigationBarLeading) {
      if colorScheme == .light {
        Image("Instagramlogo")
          .resizable()
          .scaledToFit()
          .frame(width: 90, height: 80, alignment: .leading)
      }else if colorScheme == .dark {
        Image("InstagramFontDarkMode")
          .resizable()
          .scaledToFit()
          .frame(width: 90, height: 80, alignment: .leading)
      }

    }

  }
}
