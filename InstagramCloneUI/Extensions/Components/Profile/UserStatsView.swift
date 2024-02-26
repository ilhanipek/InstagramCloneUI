//
//  UserStatsView.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 7.10.2023.
//

import SwiftUI

struct UserStatsView: View {
  var count : Int
  var statInfo : String
    var body: some View {
      VStack{
        Text("\(count)")
          .font(.headline)
          .fontDesign(.rounded)
        Text("\(statInfo)")
          .font(.headline)
          .fontDesign(.rounded)
      }
      .frame(width: .infinity, height: 60, alignment: .center)
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
      UserStatsView(count: 10, statInfo: "followers")
    }
}
