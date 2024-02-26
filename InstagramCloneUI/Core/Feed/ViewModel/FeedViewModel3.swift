//
//  FeedViewModel3.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.12.2023.
//

import Foundation
import Firebase
import SwiftUI

class FeedViewModel3 : ObservableObject {
  @Published var posts : [[Post]] = []
  var postArray : [[Post]] = []
  var refreshedPosts : [[Post]] = []

  static let shared = FeedViewModel3()
  private let service = AuthService.shared

  @MainActor
  func getSamePostsAndUser() async throws {
    let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
    var tempPostArray : [Post] = []


    for document in snapshot.documents {
      let post = try document.data(as: Post.self)
      tempPostArray.append(post)
    }

    let idResult = tempPostArray.map({$0.id})

    func countUniqueStrings(in array: [String]) -> Int {
      var uniqueStrings = Set<String>()
      for item in array {
        uniqueStrings.insert(item)
      }
      return uniqueStrings.count
    }

    let count = countUniqueStrings(in: idResult)
    if count > 0 {
      for _ in 0...count - 1 {
        let firstItemId = tempPostArray.first?.id
        let uniquePosts = tempPostArray.filter {$0.id == firstItemId}
        tempPostArray.removeAll(where: {$0.id == firstItemId})
        postArray.append(uniquePosts)

      }
      print(postArray)
    }

  }
}
