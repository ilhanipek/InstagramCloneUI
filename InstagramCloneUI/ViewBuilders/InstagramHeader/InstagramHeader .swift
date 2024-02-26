//
//  InstagramHeader .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 9.10.2023.
//

import Foundation
import SwiftUI

@ViewBuilder
func makeInstaLogo(colorScheme: ColorScheme, lightImageName: String, darkImageName: String, frameWidth: CGFloat, frameHeight: CGFloat) -> some View{
      if colorScheme == .light {
        Image(lightImageName)
          .resizable()
          .scaledToFit()
          .frame(width: frameWidth, height: frameHeight, alignment: .leading)

      }else if colorScheme == .dark {
        Image(darkImageName)
          .resizable()
          .scaledToFit()
          .frame(width: frameWidth, height: frameHeight, alignment: .leading)
      }
}
