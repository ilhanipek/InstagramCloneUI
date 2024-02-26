//
//  MainViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 17.10.2023.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class MainViewModel: ObservableObject {

  private let service = AuthService.shared
  private var cancellables = Set<AnyCancellable>()
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  init(){
    startUserSession()
  }

  func startUserSession() {
    service.$userSession.sink { [weak self] userSession in
      DispatchQueue.main.async {
        self?.userSession = userSession // nil to open loginview
      }

    }
    .store(in: &cancellables)
    service.$currentUser.sink { [weak self] currentUser in
      DispatchQueue.main.async {
        self?.currentUser = currentUser // nil to open loginview
      }
    }
    .store(in: &cancellables)
  }
}


