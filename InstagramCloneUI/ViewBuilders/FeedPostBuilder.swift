//
//  FeedPostBuilder.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 24.11.2023.
//

import Foundation
import SwiftUI
extension View {
  @ViewBuilder
  func postStack() -> some View {
    self.modifier(
      PostStackModifier()
    )
  }
}


fileprivate struct PostStackModifier : ViewModifier {

  func body(content: Content) -> some View {
    content.overlay(alignment: .center) {
      VStack {
        Text("try")
      }
    }
  }
}
