//
//  LoginTextfieldModifier.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 13.10.2023.
//

import Foundation
import SwiftUI

struct LoginTextfieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.subheadline)
      .padding(12)
      .background(Color(.systemGray6))
      .cornerRadius(10)
      .padding(.horizontal,20)
  }
}


