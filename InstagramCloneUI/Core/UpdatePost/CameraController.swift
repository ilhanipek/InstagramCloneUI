//
//  CameraController.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 21.10.2023.
//

import Foundation
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
  var sourceType : UIImagePickerController.SourceType = .photoLibrary

  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = sourceType
    imagePicker.cameraDevice = .rear

    return imagePicker
  }
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    //
  }
}
