//
//  LoginView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 11.10.2023.
//

import SwiftUI

struct LoginView: View {
  @Environment (\.colorScheme) var colorScheme
  @StateObject var loginViewModel = LoginViewModel()
  @EnvironmentObject var viewModel: RegistrationViewModel
  var body: some View {
    NavigationStack{
      VStack{
        Spacer()
        makeInstaLogo(colorScheme: colorScheme, lightImageName: "InstagramLogo", darkImageName: "InstagramFontDarkMode", frameWidth: 200, frameHeight: 80)
        TextField("Email", text: $loginViewModel.email)
          .textInputAutocapitalization(.never)
          .modifier(LoginTextfieldModifier())
        SecureField("Password", text: $loginViewModel.password)
          .textInputAutocapitalization(.never)
          .modifier(LoginTextfieldModifier())
        
        // Forgot Password Button
        Button {

          print("\(loginViewModel.email)")
        } label: {
          Text("Forgot Password?")
            .font(.footnote)
            .fontWeight(.semibold)
            .padding(.top)
            .padding(.trailing,20)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
        Button {
          Task{
            try await loginViewModel.signIn()
          }
        } label: {
          Text("Login")
            .font(.subheadline)
            .fontDesign(.rounded)
            .foregroundColor(.white)
            .frame(width: 360, height: 40, alignment: .center)
            .background {
              Color(.systemBlue)
            }
            .cornerRadius(10)
        }

        // Divider OR
        HStack{
          Rectangle()
            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5, alignment: .leading)
          Text("OR")
            .font(.footnote)
            .foregroundColor(.gray)
            .fontWeight(.semibold)
          Rectangle()
            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5, alignment: .leading)
        }.padding(.top,5)
        LoginWithFacebookButton().padding(.top,5)
        Spacer()

        // Sign up button
        NavigationLink {
          AddEmailView()

            .navigationBarBackButtonHidden()
        } label: {
          HStack(spacing: 3) {
            Text("Don't have an account?")
              .font(.callout)
            Text("Sign up")
              .font(.callout)
              .fontWeight(.bold)
          }
        }
      }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
