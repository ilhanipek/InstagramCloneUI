//
//  CompleteSignUpView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 13.10.2023.
//

import SwiftUI

struct CompleteSignUpView: View {
  @Environment (\.dismiss) var dismiss
  @EnvironmentObject var viewModel: RegistrationViewModel
  var body: some View {

    VStack {
      Text("Welcome to Instagram, \(viewModel.userName)")
        .font(.title2)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(.top)

      Text("Click below to complete registiration and start using instagram")
        .font(.footnote)
        .foregroundColor(.gray)
        .fontWeight(.semibold)
        .multilineTextAlignment(.center)
        .padding(.horizontal,20)

      Button {
        Task{
          try await viewModel.creeateUser()
        }

      } label: {
        Text("Complete Sign up")
          .font(.subheadline)
          .fontDesign(.rounded)
          .foregroundColor(.white)
          .frame(width: 350, height: 40, alignment: .center)
          .background {
            Color(.systemBlue)
          }
          .cornerRadius(10)
      }


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
}
struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
    }
}
