//
//  UserService.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.11.2023.
//

import Foundation
import Firebase

//
struct UserService {
  
  @MainActor
  static func fetchAllUsers() async throws -> [User]? {
    let snapshot = try await Firestore.firestore().collection("users").getDocuments()
    return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
  }

  static func getUserDocuments() async throws -> QuerySnapshot{
    let snapshot = try await Firestore.firestore().collection("users").getDocuments()
    return snapshot
  }
}
