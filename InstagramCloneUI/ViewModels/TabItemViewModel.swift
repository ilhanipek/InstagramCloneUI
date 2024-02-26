//
//  TabItemViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 23.10.2023.
//

import Foundation
import SwiftUI

class TabItemViewModel : ObservableObject{
  @Published var currentTabItem : CurrentView = .feed
  
  static let shared = TabItemViewModel()

  func updateCurrentTab(to currentView : CurrentView) {
    if currentTabItem != currentView {
      currentTabItem = currentView
    }
  }
}

enum CurrentView {
  case feed
  case search
  case post
  case currentProfile
}

