//
//  HomeViewModel2.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.12.2023.
//

import Foundation
import Firebase

class FeedViewModel : ObservableObject {

  @Published var posts : [[Post]] = []
  var refreshedPosts : [[Post]] = []
  @Published var likeStatus : [Bool] = []
  var refreshedLikesStatus : [Bool] = []

  static let shared = FeedViewModel()
  let currentUser = AuthService.shared.currentUser

  init() {
    Task {
      try await getFeed()
    }
  }
  
  @MainActor
  func getFeed() async throws {
    let snapshot = try await Firestore.firestore().collection("posts").getDocuments()

    var tempPostArray : [Post] = []
    var postArray : [[Post]] = []

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
        if let currentUser = currentUser {
          if uniquePosts.first!.user!.followers.contains(where: {$0 == currentUser.id}) || uniquePosts.first!.user!.id == currentUser.id {
            postArray.append(uniquePosts)
          }
        }
      }
    }
    let sortedPostArray = postArray.sorted { postArray1, postArray2 in
      return (postArray1.first?.timeStamp.dateValue())! > (postArray2.first?.timeStamp.dateValue())!
    }
    self.posts = sortedPostArray
    try await checkLikes()
  }
  
  @MainActor
  func refreshPosts() async throws {
    let snapshot = try await Firestore.firestore().collection("posts").getDocuments()

    var tempPostArray : [Post] = []
    var postArray : [[Post]] = []

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
        if let currentUser = currentUser {
          if uniquePosts.first!.user!.followers.contains(where: {$0 == currentUser.id}) || uniquePosts.first!.user!.id == currentUser.id {
            postArray.append(uniquePosts)
          }
        }
      }
    }
    let sortedPostArray = postArray.sorted { postArray1, postArray2 in
      return (postArray1.first?.timeStamp.dateValue())! > (postArray2.first?.timeStamp.dateValue())!
    }
    
    refreshedPosts = sortedPostArray
  }

  func likePost(firstImageUrl: String) async throws{
    let currentUserID = currentUser?.id
    let collectionRef = Firestore.firestore().collection("posts")
    let documents = try await collectionRef.getDocuments()
    for document in documents.documents {
      let uniqueDocument = try document.data(as: Post.self)
      if uniqueDocument.imageUrl == firstImageUrl {
        var like = document.data()["likes"] as? [String]
        like?.append(currentUserID!)
        let uniqueDocumentID = document.documentID
        let documentRef = collectionRef.document(uniqueDocumentID)
        try await documentRef.updateData(["likes": like])
      }
    }
  }

  func dislikePost(firstImageUrl: String) async throws {
      let currentUserID = currentUser?.id
      let collectionRef = Firestore.firestore().collection("posts")
      let documents = try await collectionRef.getDocuments()

      for document in documents.documents {
          let uniqueDocument = try document.data(as: Post.self)
          if uniqueDocument.imageUrl == firstImageUrl {
              var likes = uniqueDocument.likes
            if let index = likes.firstIndex(of: currentUserID!) {
                  likes.remove(at: index)
                  let uniqueDocumentID = document.documentID
                  let documentRef = collectionRef.document(uniqueDocumentID)
                  try await documentRef.updateData(["likes": likes])
              }
          }
      }
  }

  @MainActor
  func checkLikes() async throws {
      let currentUserID = currentUser?.id
      var updatedLikeStatus: [Bool] = []

      for postGroup in posts {
          if let post = postGroup.first {
              if let currentUserID = currentUserID {
                let likedByCurrentUser = post.likes.contains(currentUserID) 
                  updatedLikeStatus.append(likedByCurrentUser)
              } else {
                  updatedLikeStatus.append(false)
              }
          } else {
              updatedLikeStatus.append(false)
          }
      }
      likeStatus = updatedLikeStatus
  }

  @MainActor
  func refreshLikes() async throws {
    let currentUserID = currentUser?.id
    var refreshedLikeStatus: [Bool] = []

    for postGroup in refreshedPosts {
        if let post = postGroup.first {
            if let currentUserID = currentUserID {
              let likedByCurrentUser = post.likes.contains(currentUserID)
              refreshedLikeStatus.append(likedByCurrentUser)
            } else {
              refreshedLikeStatus.append(false)
            }
        }
    }
    self.refreshedLikesStatus = refreshedLikeStatus
  }

  @MainActor
  func fetchFeed() async throws{

    self.posts.removeAll()
    self.posts = refreshedPosts
    self.likeStatus.removeAll()
    self.likeStatus = refreshedLikesStatus
  }
}
