//
//  ProfileViewTopBarButton.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct ProfileViewTopBarButton: View {
    var body: some View {
      VStack(spacing: 5){
        RoundedRectangle(cornerRadius: 20).frame(width: 30, height: 4)
        RoundedRectangle(cornerRadius: 20).frame(width: 30, height: 4)
        RoundedRectangle(cornerRadius: 20).frame(width: 30, height: 4)

      }    }
}

struct ProfileViewTopBarButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewTopBarButton()
    }
}
