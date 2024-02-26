//
//  UpdatePostViewModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 25.10.2023.
//

import Foundation
import _PhotosUI_SwiftUI
import Firebase

class UpdatePostViewModel {
  let authService = AuthService.shared
  
  func uploadPost(uiImages: [UIImage]?, caption: String) async throws {
    let id = UUID()
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let uiImages = uiImages else { return }
    
    var postsArray: [Post] = []
    
    for i in 0..<uiImages.count {
      let postRef = Firestore.firestore().collection("posts").document()
      
      guard let imageUrl = try await ImageUploader.uploadImage(image: uiImages[i]) else { continue }
      
      let post = Post(id: id.uuidString, owneruid: uid, caption: caption, likes: [], imageUrl: imageUrl, timeStamp: Timestamp(), user: authService.currentUser)
      guard let encodedPost = try? Firestore.Encoder().encode(post) else { continue }
      try await postRef.setData(encodedPost)
      postsArray.append(post)
    }

    let userRef = Firestore.firestore().collection("users").document(uid).collection("userPosts")
    for post in postsArray {
      let encodedPost = try Firestore.Encoder().encode(post)
      try await userRef.addDocument(data: (["posts": FieldValue.arrayUnion([encodedPost])]))
    }
  }
}







