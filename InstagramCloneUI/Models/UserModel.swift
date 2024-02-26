//
//  UserModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 12.10.2023.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Hashable, Codable {

  var id : String
  var userName : String
  var bio : String?
  var imageName : String?
  var fullName : String?
  var email : String
  var followers : [String] = []
  var followings : [String] = []
  
  var isCurrentUser : Bool {
    guard let currentUid = Auth.auth().currentUser?.uid else { return false }
    return currentUid == id
  }
  
  var id2 : String {
    return "\(id)-\(Int.random(in: -10000...10000))"
  }
}

extension User {
  static var users : [User] = [
    .init(id: NSUUID().uuidString, userName: "destinazt", bio: "bio1", imageName: nil, fullName: "Destina Zeynep taban", email: "email1"),
    .init(id: NSUUID().uuidString, userName: "İlhan", bio: "bio2", fullName: "İlhan İpek", email: "email2"),
    .init(id: NSUUID().uuidString, userName: "Edo", fullName: "Erdoğan abanoz", email: "email3")
  ]
}
