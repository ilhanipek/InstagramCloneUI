//
//  HomeViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 7.11.2023.
//

import Foundation
import Firebase
import SwiftUI

class HomeViewModel : ObservableObject {
  @Published var users : [User] = []
  @Published var posts : [[Post]] = []
  
  var refreshedUsers : [User] = []
  var refreshedPosts : [[Post]] = []
  var feedStatus : FeedCoordinator = .first
  static let shared = HomeViewModel()
  private let service = AuthService.shared
  
  init() {
    Task{
      try await getSamePostsAndUser()
    }
  }

  func getPostByCurrentUserFriends() async throws{


  }

  @MainActor
  func getSamePostsAndUser() async throws {
    let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
    var tempPostArray : [Post] = []
    var postArray : [[Post]] = []
    var tempUserArray : [User] = []

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
    for _ in 0...count - 1 {
      let firstItemId = tempPostArray.first?.id
      let uniquePosts = tempPostArray.filter {$0.id == firstItemId}
      var tempUserSet = Set<User>()
      for uniquePost in uniquePosts {
        let snapshot = Firestore.firestore().collection("users").document("\(uniquePost.owneruid)")
        let postUserInfos = try await snapshot.getDocument(as: User.self)

        tempUserSet.insert(postUserInfos)
      }
      tempUserArray.append(tempUserSet.first!)
      tempPostArray.removeAll(where: {$0.id == firstItemId})
      postArray.append(uniquePosts)
    }
    // timestamp code
    let sortedPostArray = postArray.sorted { postArray1, postArray2 in
      return (postArray1.first?.timeStamp.dateValue())! > (postArray2.first?.timeStamp.dateValue())!
    }
    self.posts = postArray
    self.users = tempUserArray
  }

  @MainActor
  func refreshPostsAndUser() async throws {

    feedStatus = .reloading
    let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
    var tempPostArray : [Post] = []
    var postArray : [[Post]] = []
    var tempUserArray : [User] = []

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
    for _ in 0...count - 1 {
      let firstItemId = tempPostArray.first?.id
      let uniquePosts = tempPostArray.filter {$0.id == firstItemId}
      var tempUserSet = Set<User>()
      for uniquePost in uniquePosts {
        let snapshot = Firestore.firestore().collection("users").document("\(uniquePost.owneruid)")
        let postUserInfos = try await snapshot.getDocument(as: User.self)

        tempUserSet.insert(postUserInfos)
      }
      tempUserArray.append(tempUserSet.first!)
      tempPostArray.removeAll(where: {$0.id == firstItemId})
      postArray.append(uniquePosts)
    }

    // timestamp code
    let sortedPostArray = postArray.sorted { postArray1, postArray2 in
      return (postArray1.first?.timeStamp.dateValue())! > (postArray2.first?.timeStamp.dateValue())!
    }

    refreshedPosts = postArray
    refreshedUsers = tempUserArray

    feedStatus = .reloaded
  }

  @MainActor
  func refreshAll() async throws{

    self.posts.removeAll()
    self.users.removeAll()
    self.posts = refreshedPosts
    self.users = refreshedUsers
  }

  enum FeedCoordinator {
    case first
    case reloading
    case reloaded
  }
}




