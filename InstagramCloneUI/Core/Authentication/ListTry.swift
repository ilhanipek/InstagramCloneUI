//
//  ListTry.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 12.10.2023.
//

import SwiftUI

struct ListTry: View {
  @State var isTimeLine = true
    var body: some View {

      NavigationStack {

        VStack {
          HStack {
              Button {
                  isTimeLine = true
              } label: {
                Text("TIMELINE")
                  .frame(width: 150, height: 30, alignment: .center)
              }

              Button {
                isTimeLine = false
              } label: {
                Text("DETAILS")
                  .frame(width: 150, height: 30, alignment: .center)
              }



            }
          .frame(maxWidth: .infinity)
          if isTimeLine {
            List{
              ForEach(1...10, id: \.self) { data in
                Text("\(data)")
              }
            }
          }else {
            List {
              ForEach(1...5, id: \.self) { data in
                Text("\(data)")
              }
            }
          }
        }
        }
      }
    }


struct ListTry_Previews: PreviewProvider {
    static var previews: some View {
        ListTry()
    }
}
