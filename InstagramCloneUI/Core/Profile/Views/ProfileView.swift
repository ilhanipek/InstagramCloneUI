//
//  ProfileView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
  let user: User
  @Environment (\.dismiss) var dismiss
  let gridItems : [GridItem] = [
    .init(.flexible(), spacing: 1),
    .init(.flexible(), spacing: 1),
    .init(.flexible(), spacing: 1)
  ]

  let photoDimension: CGFloat = (UIScreen.main.bounds.width / 3 ) - 1
  var posts : [Post] {
    return Post.posts.filter({$0.user?.userName == user.userName})
  }
  @State var sheetPresented = false
  @ObservedObject var followViewModel = FollowViewModel()
  
  var body: some View {
    //NavigationStack {
    ScrollView{
      // Header
      VStack {
        // Profile & Stats HStack
        HStack {
          VStack(alignment: .leading) {
            HStack {
              ZStack{
                Circle()
                  .stroke(style: .init(lineWidth: 2, lineCap: .round))
                  .frame(width: 80, height: 80, alignment: .center)
                Circle()
                  .foregroundColor(.gray.opacity(0.8))
                  .frame(width: 80, height: 80, alignment: .center)
                if let profileImage = user.imageName {
                  KFImage(URL(string: profileImage))
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipShape(Circle())
                }else{
                  Image(systemName: "person.fill")
                    .font(.largeTitle)
                }


              }.padding(.init(top: 0, leading: 10, bottom: 5, trailing: 0))
              HStack(spacing: 20){
                UserStatsView(count: 10, statInfo: "Posts")
                UserStatsView(count: 100, statInfo: "Followers")
                UserStatsView(count: 200, statInfo: "Following")
              }.padding(.leading,25)
            }
            if let fullName = user.fullName {
              Text(fullName)
                .font(.footnote)
                .bold()
                .padding(.init(top: 5, leading: 10, bottom: 2, trailing: 0))
            }
            if let bio = user.bio {
              Text(bio)
                .font(.footnote)
                .bold()
                .padding(.init(top: 0, leading: 10, bottom: 5, trailing: 0))
            }
          }
          .frame(maxWidth: .infinity,alignment: .leading)

        }
        Button {
          if user.isCurrentUser {
            sheetPresented = true
          }else {
            if followViewModel.isFollowing {
              followViewModel.unfollowUser(user: user)
              followViewModel.isFollowing = false
            }else {
              followViewModel.followUser(user: user)
              followViewModel.isFollowing = true
            }

          }
        } label: {
          Text(user.isCurrentUser ? "Edit" : followViewModel.isFollowing ? "Unfollow" : "Follow")
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 360, height: 32, alignment: .center)
            .background(user.isCurrentUser ? Color.white : followViewModel.isFollowing ? Color.white : Color.blue)
            .cornerRadius(10)
            .foregroundStyle(user.isCurrentUser ? Color.black : followViewModel.isFollowing ? Color.black : Color.white)
            .overlay {
              RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, style: .init(lineWidth: 2))
            }
        }
        Divider().bold()
        Spacer()
      }
      // Post Stack
      LazyVGrid(columns: gridItems, spacing: 1) {
        ForEach(posts, id: \.self) { post in
          Image(post.imageUrl)
            .resizable()
            .scaledToFill()
            .frame(width: photoDimension, height: photoDimension)
            .clipped()
        }
      }
    }
    .onAppear {
      Task{
        try await followViewModel.checkUserFollowingInfo(user: user)
        print(followViewModel.isFollowing)
      }
    }
    .sheet(isPresented: $sheetPresented, onDismiss: {
      sheetPresented = false
    }, content: {
      EditProfileView(user: user)
    })
    .navigationTitle(user.userName)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Image(systemName: "chevron.left")
          .onTapGesture {
            dismiss()
          }
      }
    }
    //}
  }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
      ProfileView(user: User.users[1])
    }
}
