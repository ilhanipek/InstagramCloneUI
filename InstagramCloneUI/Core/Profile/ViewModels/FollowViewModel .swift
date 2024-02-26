//
//  FollowViewModel .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 3.12.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class FollowViewModel: ObservableObject {
  @Published var isFollowing : Bool = false
  let currentUser = AuthService.shared.currentUser
  
  @MainActor
  func checkUserFollowingInfo(user: User) async throws {
    let collectionRef = Firestore.firestore().collection("users")
    let currentUserID = currentUser?.id
    let documentRef = collectionRef.document(user.id)
    
    do {
      let document = try await documentRef.getDocument()
      if document.exists {
        if let profileData = try? document.data(as: User.self) {
          
          var followersArray: [String] = []
          
          for follower in profileData.followers {
            followersArray.append(follower)
          }
          print(followersArray)
          
          if let currentUsersID = currentUserID {
            let filteredFollowersArray = followersArray.filter { $0 == currentUsersID }
            if filteredFollowersArray.isEmpty {
              self.isFollowing = false
            } else {
              self.isFollowing = true
            }
          }
        }
      }
    }
  }
  
  @MainActor
  func followUser(user: User){
    let collectionRef = Firestore.firestore().collection("users")
    let currentUserID = currentUser?.id
    let documentRef = collectionRef.document(user.id)
    
    documentRef.getDocument { (document, error) in
      if let error = error {
        print("Belge alınamadı: \(error)")
        return
      }
      
      if let document = document, document.exists {
        
        var currentFollowers = document.data()?["followers"] as? [String] ?? []
        currentFollowers.append(currentUserID!)
        
        
        documentRef.updateData(["followers": currentFollowers]) { error in
          if let error = error {
            print("Değer güncellenemedi: \(error)")
          } else {
            print("Değer başarıyla güncellendi.")
          }
        }
      } else {
        print("Belge bulunamadı veya boş.")
      }
    }
  }
  @MainActor
  func unfollowUser(user: User){
    let collectionRef = Firestore.firestore().collection("users")
    let currentUserID = currentUser?.id
    let documentRef = collectionRef.document(user.id)
    
    // Belirtilen belgeyi alın
    documentRef.getDocument { (document, error) in
      if let error = error {
        print("Belge alınamadı: \(error)")
        return
      }
      
      if let document = document, document.exists {
        var currentFollowers = document.data()?["followers"] as? [String] ?? []
        
        // Öğeyi kaldır
        if let index = currentFollowers.firstIndex(of: currentUserID ?? "") {
          currentFollowers.remove(at: index)
        }
        
        // Güncellenmiş diziyi Firestore'a geri gönder
        documentRef.updateData(["followers": currentFollowers]) { error in
          if let error = error {
            print("Değer güncellenemedi: \(error)")
          } else {
            print("Değer başarıyla güncellendi.")
          }
        }
      } else {
        print("Belge bulunamadı veya boş.")
      }
    }
  }

  @MainActor
  func saveCurrentUserIDToFollowedUsersPosts(){
    
  }

}







