//
//  FeedCell2.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 20.11.2023.
//

import SwiftUI
import Kingfisher

struct FeedCell2 : View {
  @StateObject var feedViewModel = FeedViewModel.shared
  @StateObject private var isLiked = Like()
  @State private var isCommentPresented = false
  let currentUser = AuthService.shared.currentUser
  var body: some View {
    ScrollView {

      LazyVStack {

        ForEach(0..<feedViewModel.posts.count,id: \.self) { i in

          VStack {
            // Profile picture & Username
            HStack {
              if let profileImageName = feedViewModel.posts[i].first?.user?.imageName {
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
              Text((feedViewModel.posts[i].first?.user!.userName)!)
              Spacer()
            }
            .padding(.leading,10)
            // Post photo
            VStack {
              TabView {
                ForEach(feedViewModel.posts[i],id: \.imageUrl){ post in
                  KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 1.150, height: UIScreen.main.bounds.height / 2.7, alignment: .leading)
                    .clipShape(Rectangle())
                    .tag(post.id)
                }
              }
              .frame(height: UIScreen.main.bounds.height / 2.7)
              .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
              .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }

            HStack(spacing: 15) {
              Button {
                Task {
                  if let imageUrl = feedViewModel.posts[i].first?.imageUrl {
                    if feedViewModel.likeStatus[i] == false {
                      feedViewModel.likeStatus[i].toggle()
                      print(feedViewModel.likeStatus)
                      try await feedViewModel.likePost(firstImageUrl: imageUrl)
                    } else {
                      feedViewModel.likeStatus[i].toggle()
                      print(feedViewModel.likeStatus)
                      try await feedViewModel.dislikePost(firstImageUrl: imageUrl)
                    }
                  }
                }
              } label: {
                Image(systemName: feedViewModel.likeStatus[i] ? "heart.fill" : "heart")
                  .resizable()
                  .scaledToFill()
                  .foregroundColor(.themes.customAccent)
                  .frame(width: 25, height: 25, alignment: .center)
              }

              Button {
                isCommentPresented = true
              } label: {
                Image(systemName: "bubble.right")
                  .resizable()
                  .scaledToFill()
                  .foregroundColor(.themes.customAccent)
                  .frame(width: 25, height: 25, alignment: .center)
              }
              Button {
                //
              } label: {
                Image(systemName: "paperplane")
                  .resizable()
                  .scaledToFill()
                  .foregroundColor(.themes.customAccent)
                  .frame(width: 25, height: 25, alignment: .center)
                  .cornerRadius(10)
              }
              Spacer()
            }.padding(.leading,10)

            VStack {
              HStack {
                Text("150 likes")
                Spacer()
              }
              .font(.headline)
              .bold()
              HStack{
                if let fullName = feedViewModel.posts[i].first?.user?.fullName {
                  Text("\(fullName)")
                    .font(.headline)
                    .bold()
                }else {
                  Text(feedViewModel.posts[i].first?.user?.userName ?? "")
                    .font(.headline)
                    .bold()
                }
                if let firstPost = feedViewModel.posts[i].first {
                  Text("\(firstPost.caption)")
                    .font(.subheadline)
                }
                Spacer()
              }
              HStack{
                Text("150 comment")
                Spacer()
              }
              HStack{
                Text(feedViewModel.posts[i].first?.timeFromTimestamp() ?? "")
                Spacer()
              }
              .foregroundStyle(Color.black.opacity(0.7))
            }
            .padding(.leading,10)
          }
          .padding(.bottom,50)
        }
        .padding()
      }
    }
  }
}

struct FeedCell_Previews: PreviewProvider {
  static var previews: some View {
    FeedCell2()
  }
}

