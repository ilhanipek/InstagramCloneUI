//
//  AddEmailView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 11.10.2023.
//

import SwiftUI

struct AddEmailView: View {
  @Environment (\.dismiss) var dismiss
  
  @EnvironmentObject var viewModel : RegistrationViewModel
  var body: some View {
    VStack(spacing: 10) {

      Text("Add your email")
        .font(.title2)
        .fontWeight(.bold)
        .padding(.top)

      Text("You'll use this to sign in to your account")
        .font(.footnote)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal,20)
      TextField("Email", text: $viewModel.email)
        .textInputAutocapitalization(.never)
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal,20)
      NavigationLink {
        CreateUserNameView()
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
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
