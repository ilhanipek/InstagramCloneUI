//
//  EditProfileView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.11.2023.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

struct EditProfileView : View {
  @Environment (\.dismiss) var dismiss
  @StateObject var viewModel : CurrentProfileViewModel
  init(user: User) {
    self._viewModel = StateObject(wrappedValue: CurrentProfileViewModel(user: user))
  }

  var body: some View {
    VStack{
      HStack {
        Button {
          dismiss()
        } label: {
          Text("Cancel")
        }
        Spacer()
        Text("Edit Profile")
          .fontWeight(.semibold)
        Spacer()
        Button {
          Task {
            try await viewModel.updateUserData()
            dismiss()
          }
        } label: {
          Text("Done")
        }
      }
      Divider()
      PhotosPicker(selection: $viewModel.selectedImage) {
        VStack {
          if let image = viewModel.profileImage {
            image
              .resizable()
              .foregroundStyle(Color.white)
              .background(.gray)
              .clipShape(Circle())
              .frame(width: 90, height: 90, alignment: .center)
          }else{
            CircularProfileImageView(user: viewModel.user)
          }
          Text("Edit profile image")
            .font(.footnote)
            .fontWeight(.semibold)
        }
      }
      .padding(.vertical, 20)
      Divider()
      List{
        HStack {
          Text("Name:")
            .frame(width: 100, alignment: .leading)
          TextField("Enter your name", text: $viewModel.fullName)

        }
        HStack {
          Text("Bio:")
            .frame(width: 100, alignment: .leading)
          TextField("Enter your bio", text: $viewModel.bio)

        }

      }
      .listStyle(.inset)
      Spacer()
    }
    .padding(.vertical,5)
    .padding(.horizontal)

  }
}
