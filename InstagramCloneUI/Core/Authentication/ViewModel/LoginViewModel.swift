//
//  LoginViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 1.11.2023.
//

import Foundation

class LoginViewModel : ObservableObject {
  @Published var email = ""
  @Published var password = ""

  func signIn() async throws {
    try await AuthService.shared.login(email: email, password: password)
  }
}
