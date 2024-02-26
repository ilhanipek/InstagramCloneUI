//
//  RegistrationViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 17.10.2023.
//

import Foundation

class RegistrationViewModel: ObservableObject {
  @Published var userName = ""
  @Published var email = ""
  @Published var password = ""

  @MainActor
  func creeateUser() async throws {
    try await AuthService.shared.createUser(email: email, password: password, userName: userName)

    userName = ""
    email = ""
    password = ""
  }
}
