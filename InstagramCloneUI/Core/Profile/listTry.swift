//
//  listTry.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 18.10.2023.
//

import SwiftUI

struct listTry: View {
    var body: some View {
      VStack{
        List{
            HStack {
              Text("1")
              Text("hi")
            }
          Text("hi2")
          .listRowSeparator(.hidden)
          Text("hi2")
          Text("hi2")
        }
      }
    }
}

struct listTry_Previews: PreviewProvider {
    static var previews: some View {
        listTry()
    }
}
