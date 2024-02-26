//
//  asd.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 11.10.2023.
//

import Foundation

class dateFormatter : ObservableObject {
  @Published var date = "12092001"
  func formatDate() -> Date {

    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter.date(from: date)!
  }
}


