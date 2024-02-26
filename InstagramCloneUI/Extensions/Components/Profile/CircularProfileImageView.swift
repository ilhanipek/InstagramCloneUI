//
//  CircularProfileImageView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 6.11.2023.
//

import SwiftUI
import Kingfisher
struct CircularProfileImageView: View {
  let user : User
    var body: some View {
      if let imageUrl = user.imageName {

        KFImage(URL(string: imageUrl))
          .resizable()
          .scaledToFill()
          .frame(width: 80, height: 80, alignment: .center)
          .clipShape(Circle())

      }else {
        Image(systemName: "person.circle.fill")
          .resizable()
          .frame(width: 80, height: 80, alignment: .center)
          .clipShape(Circle())
          .foregroundStyle(Color(.systemGray4))
      }
    }
}

#Preview {
  CircularProfileImageView(user: User.users[0])
}
