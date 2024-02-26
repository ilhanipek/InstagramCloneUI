//
//  EditProfileViewModel .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 6.11.2023.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

class EditProfileViewModel : ObservableObject {
  @Published var userName : String = ""
  @Published var bio : String = ""
  @Published var profileImage: Image?
  @Published var selectedImage: PhotosPickerItem?
  
}
