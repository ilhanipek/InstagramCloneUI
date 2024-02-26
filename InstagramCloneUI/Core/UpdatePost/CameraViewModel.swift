import Foundation
import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var caption: String = ""
    @Published var image: Image = Image(systemName: "desti3")
    var imageData: Data = Data()
    var errorString = ""

    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false


    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {

    }
}
