//
//  CurrentProfileViewModel .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.11.2023.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI
import Firebase

class CurrentProfileViewModel : ObservableObject {
  @Published var fullName = ""
  @Published var bio = ""
  @Published var profileImage: Image?
  @Published var user: User
  @Published var selectedImage: PhotosPickerItem? {
    didSet {
      Task {
        await loadImage(fromItem: selectedImage)
      }
    }
  }
  
  private var uiImage : UIImage?

  init(user: User) {
    self.user = user

    if let fullName = user.fullName {
      self.fullName = fullName
    }
    if let bio = user.bio {
      self.bio = bio
    }
  }

  @MainActor
  func loadImage(fromItem item: PhotosPickerItem?) async {
    guard let item = item else { return }
    guard let data = try? await item.loadTransferable(type: Data.self) else { return }
    guard let uiImage = UIImage(data: data) else { return }
    self.profileImage = Image(uiImage: uiImage)
    self.uiImage = uiImage
  }

  @MainActor
  func updateUserData() async throws{
    var data = [String : Any]()

    if let uiImage = uiImage {
      let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
      data["imageName"] = imageUrl
    }
    // update name if changed
    if !fullName.isEmpty && fullName != user.fullName {
      data["fullName"] = fullName
    }
    // update bio if changed
    if !bio.isEmpty && bio != user.bio {
      data["bio"] = bio
    }

    if data != nil {
      try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
  }
}


