//
//  photosPicker.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 21.10.2023.
//

import SwiftUI
import PhotosUI
struct photosPickerView: View {
  @State var photosPickerItem : [PhotosPickerItem] = []
  @State var isPresented = false
  @State var isPhotosPickerPresented = false

  var body: some View {
    VStack {
      VStack{
        
      }
      .frame(width: 100, height: 100, alignment: .center)
      .overlay {
        ScrollView{
          if isPhotosPickerPresented == true {
            PhotosPicker("Photos", selection: $photosPickerItem, matching: .images, preferredItemEncoding: .automatic)
          }
        }
      }
    }
    .onAppear(perform: {
      isPhotosPickerPresented = true
    })
  }
}


#Preview {
  photosPickerView()
}
