//
//  ImageHStack.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 20.11.2023.
//

import SwiftUI
import Kingfisher

struct ImageHStack: View {
  @StateObject var homeViewModel = HomeViewModel.shared
  let post : Post
    var body: some View {

      VStack {
        GeometryReader(content: { geometry in
          let size = geometry.size
          ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10, content: {
              ForEach(homeViewModel.posts, id: \.self){ posts in
                ForEach(posts) { post in
                  GeometryReader { proxy in
                    let imageSize = proxy.size
                    KFImage(URL(string: post.imageUrl))
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: imageSize.width, height: imageSize.height / 1, alignment: .center)
                      .clipShape(.rect(cornerRadius: 8))
                  }

                }
              }
            })
            .padding(.horizontal, 26)
            .scrollTargetLayout()
          }
        })
      }
    }
}

#Preview {
  ImageHStack(post: Post.posts[0])
}
