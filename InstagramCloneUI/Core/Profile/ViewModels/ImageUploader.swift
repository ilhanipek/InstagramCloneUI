//
//  ImageUploader.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 6.11.2023.
//

import Foundation
import SwiftUI
import FirebaseStorage

class ImageUploader {

  static func uploadImage(image : UIImage) async throws -> String? {

    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
    let fileName = NSUUID().uuidString
    let storageRef = Storage.storage().reference(withPath: "/profile_images\(fileName)")
    do {
      let _ = try await storageRef.putDataAsync(imageData)
      let url = try await storageRef.downloadURL()
      return url.absoluteString
    }catch {
      print("\(error.localizedDescription)")
      return nil
    }


  }
}
