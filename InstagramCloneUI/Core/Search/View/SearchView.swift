//
//  SearchView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct SearchView: View {

  @StateObject var searchViewModel = SearchViewModel()
  @State private var isSearching : Bool = false
  var body: some View {
    NavigationStack(){

      ScrollView{

        LazyVStack {

          ForEach(searchViewModel.users, id: \.self){ user in

            NavigationLink(value: user) {
              ZStack {
                HStack() {
                  ZStack{
                    if user.imageName != nil {
                      Image(user.imageName ?? "")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40, alignment: .center)
                    }else {
                      Circle()
                        .stroke(style: .init(lineWidth: 2, lineCap: .round))
                        .frame(width: 40, height: 40, alignment: .center)
                      Circle()
                        .foregroundColor(.gray.opacity(0.8))
                        .frame(width: 40, height: 40, alignment: .center)
                      Image(systemName: "person.fill")
                        .font(.title2)
                    }
                  }
                  VStack(alignment: .leading) {
                    Text(user.userName)
                      .fontWeight(.semibold)
                    Text(user.fullName ?? "")
                  }
                  .font(.footnote)
                  Spacer()
                }
                .foregroundColor(.black)
                .padding(.leading,15)
              }
            }
          }
        }
      }
      .onChange(of: searchViewModel.searchText, {
        Task{
          if searchViewModel.searchText != "" {
            try await searchViewModel.fetchSearchedUsers()
          } else {
            try await searchViewModel.deleteSearchedUsers()
          }
        }
      })
      .searchable(text: $searchViewModel.searchText)
      .navigationDestination(for: User.self, destination: { user in
        ProfileView(user: user)
          .navigationBarBackButtonHidden()
      })
      .navigationTitle("Explore")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
