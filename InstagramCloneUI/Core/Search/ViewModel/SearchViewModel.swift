//
//  SearchViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.11.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class SearchViewModel : ObservableObject {
  @Published var users = [User]()
  @Published var searchText = ""

  let currentUser = AuthService.shared.currentUser
  
  @MainActor
  func fetchSearchedUsers() async throws {
    if searchText != "" {
      let collectionRef = Firestore.firestore().collection("users")

      do {
        let querySnapshot = try await collectionRef.getDocuments()

        var searchedUsers: [User] = []

        for document in querySnapshot.documents {
          if let user = try? document.data(as: User.self) {
            let username = user.userName.lowercased()

            let usernameChars = username.map { String($0) }

            if usernameChars.contains(searchText.lowercased()) {
              searchedUsers.append(user)
            }
          }
        }
        print(searchedUsers)
        self.users = searchedUsers
      } catch {
        print("Arama işlemi başarısız oldu: \(error)")
      }
    }
  }

  @MainActor
  func deleteSearchedUsers() async throws{
    users.removeAll()
  }

  @MainActor
  func fetchForUsersFriends() async throws {
    if searchText != "" {
      let collectionRef = Firestore.firestore().collection("users")
      let currentUserID = currentUser?.id
      let documentRef = collectionRef.document(currentUserID!)
      let currentUser = try await documentRef.getDocument(as: User.self)
    }
  }
}
