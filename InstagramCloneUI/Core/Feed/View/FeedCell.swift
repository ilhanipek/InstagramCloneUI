
import SwiftUI
import Kingfisher

struct FeedCell: View {
  @StateObject var viewModel = HomeViewModel.shared
  @StateObject private var isLiked = Like()

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewModel.users, id: \.id) { user in
          VStack {
            HStack {
              if let profileImageName = user.imageName {
                KFImage(URL(string: profileImageName))
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30, alignment: .center)
                  .clipShape(Circle())
              } else {
                ZStack {
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
              Text(user.userName)
              Spacer()
            }
            .padding(.leading,10)
            VStack{
              if let userPosts = viewModel.posts.first(where: { $0.first?.owneruid == user.id }) {
                TabView {
                  ForEach(userPosts, id: \.imageUrl) { post in
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
                CustomButton(systemName: isLiked.isLiked ? "heart.fill": "heart" , status: isLiked.isLiked, activeTint: .red, inActiveTint: .themes.customAccent) {
                  if isLiked.isLiked == false {
                    withAnimation(.spring(response: 0.70, dampingFraction: 0.70)) {
                      isLiked.isLiked.toggle()
                    }
                  } else {
                    withAnimation(.none) {
                      isLiked.isLiked.toggle()
                    }
                  }
                }
                Button {
                  //
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
              }.padding(.leading)

            }
            .padding(.bottom, 50)

          }
        }
        .padding()
      }
    }

  }
}

