//
//  CreatePasswordView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 12.10.2023.
//

import SwiftUI

struct CreatePasswordView: View {
  @Environment (\.dismiss) var dismiss
  @EnvironmentObject var viewModel: RegistrationViewModel

  var body: some View {
    VStack(spacing: 10) {
      Text("Create Password")
        .font(.title2)
        .fontWeight(.bold)
        .padding(.top)
      Text("You'll use this to login")
        .font(.footnote)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal,20)
      TextField("Password", text: $viewModel.password)
        .textInputAutocapitalization(.never)
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal,20)
      NavigationLink {
        CompleteSignUpView()
          .navigationBarBackButtonHidden()

      } label: {
        Text("Next")
          .font(.subheadline)
          .fontDesign(.rounded)
          .foregroundColor(.white)
          .frame(width: 350, height: 40, alignment: .center)
          .background {
            Color(.systemBlue)
          }
          .cornerRadius(10)
      }

      Spacer()
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Image(systemName: "chevron.left")
          .onTapGesture {
            dismiss()
          }
      }
    }
  }

  struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
      CreatePasswordView()
    }
  }
}
