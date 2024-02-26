//
//  UpdatePostView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 25.10.2023.
//

import SwiftUI
import PhotosUI

struct UpdatePostView: View {
  @Environment(\.dismiss) var dismiss

  private var screenWidth = UIScreen.main.bounds.width
  private var screenHeight = UIScreen.main.bounds.height
  @State private var isForwardActive = true
  @State private var moreThanOne = true
  @State private var moreThanOneIcon = false
  @State private var isMoreThanOneActive = false
  @State private var textFieldText = ""
  @State private var isTextfieldPresented = false
  @State private var textfieldCaption = "Enter your caption"
  // Upload Post
  private let updatePostViewModel = UpdatePostViewModel()
  @State var selectedPhotos: [PhotosPickerItem] = []
  @State var dataArray: [Data] = []
  @State var uiImages : [UIImage] = []
  var body: some View {
    NavigationStack {

      VStack {
        Divider()
        if dataArray.isEmpty {
          VStack {
            PhotosPicker(selection: $selectedPhotos, maxSelectionCount: isMoreThanOneActive ? 10 : 1, selectionBehavior: .default, matching: .images) {
              Image(systemName: "plus.app.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.vertical,70)
                .tint(.themes.customAccent)
                .onChange(of: selectedPhotos) {
                  dataArray.removeAll()
                  for i in 0..<selectedPhotos.count {
                    if selectedPhotos[i] == nil {
                      continue
                    } else {
                      selectedPhotos[i].loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                          if let data = data {
                            dataArray.append(data)
                            for data in dataArray {
                              print(data)
                            }
                          }
                        case .failure(let error):
                          print(error)
                        }
                      }
                    }
                  }
                }
            }
            VStack {
              Divider()
                .padding(.vertical,10)

              HStack() {
                MoreThanOneButton(isMoreThanOne: $moreThanOne, isMoreThanOneIcon: $moreThanOneIcon, isMoreThanOneActive: $isMoreThanOneActive)
                Spacer()
              }
              .frame(maxWidth: .infinity)
              .padding(.leading,12)
              Spacer()
            }
            Spacer()
          }
        } else {
          VStack {
            GeometryReader(content: { geometry in
              let size = geometry.size
              ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10, content: {
                  ForEach(dataArray, id: \.self) { data in
                    GeometryReader { proxy in
                      let imageSize = proxy.size
                      if let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: imageSize.width, height: imageSize.height / 1, alignment: .center)
                          .clipShape(.rect(cornerRadius: 8))
                          .onAppear {
                            uiImages.append(uiImage)
                          }
                      }
                    }
                    .frame(width: size.width - 52)
                  }
                  PhotosPicker(selection: $selectedPhotos, maxSelectionCount: isMoreThanOneActive ? 10 : 1, selectionBehavior: .default, matching: .images) {

                    Image(systemName: "plus.circle")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 100, height: 100)

                      .tint(.themes.customAccent)
                      .onChange(of: selectedPhotos) {
                        DispatchQueue.main.async {
                          dataArray.removeAll()
                          uiImages.removeAll()
                          for i in 0..<selectedPhotos.count {
                            if selectedPhotos[i] == nil {
                              continue
                            } else {
                              selectedPhotos[i].loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                  if let data = data {
                                    dataArray.append(data)
                                  }
                                case .failure(let error):
                                  print(error)
                                }
                              }
                            }
                          }
                        }
                      }
                  }
                })
                .padding(.horizontal, 26)
                .scrollTargetLayout()
              }
              .scrollTargetBehavior(.viewAligned)
            })
            .scrollIndicators(.hidden)

            VStack {
              Divider()
                .padding(.bottom,30)

              HStack() {
                MoreThanOneButton(isMoreThanOne: $moreThanOne, isMoreThanOneIcon: $moreThanOneIcon, isMoreThanOneActive: $isMoreThanOneActive)
                  .padding(.leading, 12)
                Spacer()
              }

              HStack {
                TextField(textfieldCaption, text: $textFieldText, axis: .vertical)
                  .padding(.top,5)
                  .padding(.leading,5)
                  .frame(width: isTextfieldPresented ? screenWidth - 20 : 0, height: 100, alignment: .top)
                  .background(alignment: .leading){
                    RoundedRectangle(cornerRadius: 10)
                      .stroke()
                  }
                  .padding(.leading, 10)
                  .padding(.top,10)
                Spacer()
              }
              .frame(maxWidth: .infinity)
              Spacer()
            }
          }
          .onAppear {
            Task {
              withAnimation(.linear(duration: 1.0)) {
                isTextfieldPresented.toggle()
              }
            }
          }
          .onDisappear {
            isTextfieldPresented.toggle()
          }
        }
      }
      .onTapGesture {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
      .navigationTitle("New Post")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar{
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            Task {
              print(uiImages.count)
              try await updatePostViewModel.uploadPost(uiImages: uiImages, caption: textFieldText)
              await clearPostData()
            }
          } label: {
            Text("Forward")
              .foregroundStyle(Color.themes.customAccent)
          }
        }
      }
    }
  }
  func clearPostData() async {
    dataArray.removeAll()
    uiImages.removeAll()
    textFieldText = ""
  }
}

#Preview {
    UpdatePostView()
}


