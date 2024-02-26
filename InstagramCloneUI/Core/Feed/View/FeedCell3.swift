//
//  FeedCell3.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 27.11.2023.
//

import Foundation

import SwiftUI
import Kingfisher

struct FeedCell3: View {
  @StateObject var viewModel = HomeViewModel.shared
  @StateObject private var isLiked = Like()

  var body: some View {
    ScrollView {
      LazyVStack{
        ForEach(0..<viewModel.users.count,id: \.self) { i in
          VStack {
            HStack {
              if let profileImageName = viewModel.users[i].imageName {
                KFImage(URL(string: profileImageName))
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30, alignment: .center)
                  .clipShape(Circle())
              }else {
                ZStack{
                  Circle()
                    .stroke(style: .init(lineWidth: 2, lineCap: .round))
                    .frame(width: 30, height: 30, alignment: .center)
                  Circle()
                    .foregroundColor(.gray.opacity(0.8))
                    .frame(width: 30, height: 30, alignment: .center)
                  Image(systemName: "person.fill")
                    .font(.title3)
                }
              }
              Text(viewModel.users[i].userName)
              Spacer()
            }
            .padding(.leading,10)
            VStack {
              GeometryReader(content: { geometry in
                let size = geometry.size
                ScrollView(.horizontal) {
                  HStack(alignment: .center, spacing: 10, content: {
                    ForEach(viewModel.posts[i],id: \.imageUrl) { post in
                      GeometryReader { proxy in
                        let imageSize = proxy.size
                        KFImage(URL(string: post.imageUrl))
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 3.5, alignment: .center)
                          .clipShape(.rect(cornerRadius: 8))
                      }
                    }
                  })
                  .padding(.horizontal, 26)
                  .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
              })
              .scrollIndicators(.hidden)
            }

            HStack {
              CustomButton(systemName: isLiked.isLiked ? "heart.fill": "heart" , status: isLiked.isLiked, activeTint: .red, inActiveTint: .themes.customAccent) {
                if isLiked.isLiked == false {
                  withAnimation(.spring(response: 0.70, dampingFraction: 0.70)) {
                    isLiked.isLiked.toggle()
                  }
                }else {
                  withAnimation(.none) {
                    isLiked.isLiked.toggle()
                  }
                }
              }
            }
          }
          .padding(.top,100)
        }
      }
      .padding()
    }
    .onAppear {
      print(viewModel.users)
    }
  }
}

#Preview {
  FeedCell()
}
