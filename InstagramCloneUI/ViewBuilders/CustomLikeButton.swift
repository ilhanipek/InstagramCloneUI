//
//  CustomLikeButton.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 14.10.2023.
//

import Foundation
import SwiftUI

@ViewBuilder
func CustomButton(systemName: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping ()->()) async -> some View {
  Button(action: onTap) {
    Image(systemName: systemName)
      .resizable()
      .scaledToFill()
      .frame(width: 25, height: 25, alignment: .center)
      .foregroundColor(status ? activeTint : inActiveTint)
  }
}
