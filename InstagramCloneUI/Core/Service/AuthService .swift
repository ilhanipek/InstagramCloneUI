//
//  AuthService .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 17.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
class AuthService {

  // Value to control user session
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  static let shared = AuthService()
  init(){
    Task{
      try? await loadCurrentUserData()
    }
  }

  func login(email: String, password: String) async throws{
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      try await loadCurrentUserData()
      } catch {
      print("\(error.localizedDescription)")
    }
  }

  @MainActor
  func createUser(email: String, password: String, userName: String) async throws{

    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      await uploadUserData(uid: result.user.uid, username: userName, email: email)
    } catch {
      print("Failed to create user")
    }
  }
  @MainActor
  func loadCurrentUserData() async throws {
    self.userSession = Auth.auth().currentUser
    guard let currentUserId = userSession?.uid else { return }
    let snapshot = try? await Firestore.firestore().collection("users").document(currentUserId).getDocument()
    self.currentUser = try? snapshot?.data(as: User.self)
    
  }

  func signOut(){
    try? Auth.auth().signOut()

    self.userSession = nil
    self.currentUser = nil 
  }

  private func uploadUserData(uid: String, username: String , email: String) async {
    let user = User(id: uid, userName: username, email: email)
    self.currentUser = user
    guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
    try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
  }
}
