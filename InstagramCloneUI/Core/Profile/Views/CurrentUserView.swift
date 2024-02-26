//
//  CurrentUserView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 14.10.2023.
//

import SwiftUI

struct CurrentUserView: View {
  let gridItems : [GridItem] = [
    .init(.flexible(), spacing: 1),
    .init(.flexible(), spacing: 1),
    .init(.flexible(), spacing: 1)
  ]
  let photoDimension = (UIScreen.main.bounds.width / 3 ) + 1

  var posts : [Post] {
    return Post.posts.filter({$0.user?.userName == user.userName})
  }
  @State var sheetPresented = false
  @State var isEditProfilePresented = false
  @State var user: User 
    var body: some View {
      NavigationStack {
        ScrollView{
          // Header
          VStack {
            // Profile & Stats HStack
            HStack {
              VStack(alignment: .leading) {
                HStack {
                  CircularProfileImageView(user: user)
                    .padding(.leading,7)
                  HStack(spacing: 20){
                    UserStatsView(count: 10, statInfo: "Posts")
                    UserStatsView(count: 100, statInfo: "Followers")
                    UserStatsView(count: 200, statInfo: "Following")
                  }
                  .padding(.leading,25)
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
              isEditProfilePresented.toggle()
            } label: {
              Text("Edit Profile")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 360, height: 32, alignment: .center)
                .foregroundStyle(Color.themes.customAccent)
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
        .fullScreenCover(isPresented: $isEditProfilePresented, content: {
          EditProfileView(user: user)
        })
        .navigationTitle(user.userName)
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Button {
                sheetPresented.toggle()
              } label: {
                ProfileViewTopBarButton()
              }
              .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
              .foregroundColor(.black)
              .sheet(isPresented: $sheetPresented) {
                List{
                  Button {
                    AuthService.shared.signOut()
                  } label: {
                    Text("Sign out")
                  }
                  Button {
                    //
                  } label: {
                    Text("Settings")
                  }
                }
                .presentationDetents([.medium,.large])
              }
            }
          }
      }
    }
}

struct CurrentUserView_Previews: PreviewProvider {
    static var previews: some View {
      CurrentUserView(user: User.users[0])
    }
}
