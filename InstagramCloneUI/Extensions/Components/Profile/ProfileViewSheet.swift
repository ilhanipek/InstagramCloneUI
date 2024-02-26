//
//  ProfileViewSheet.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 8.10.2023.
//

import SwiftUI

struct ProfileViewSheet: View {
  @State var isSheetPresented = false
  @ObservedObject var sheetViewModel = SheetViewModel()
  enum SheetSize {
    case medium
    case large
  }
  var body: some View {
    VStack{
      Button {
        isSheetPresented.toggle()
      } label: {
        Text("Open Sheet")
      }
      .sheet(isPresented: $isSheetPresented) {
        List{
          ForEach(0...15,id: \.self) { number in
            Text("Number: \(number)")
          }
        }.presentationDetents([sheetViewModel.sheetSize])
      }
      
      HStack {
        Button {
          sheetViewModel.setSheetSize(selectedSize: .large)
        } label: {
          Text("Make large sheet")
        }
        Button {
          sheetViewModel.setSheetSize(selectedSize: .medium)
        } label: {
          Text("Make medium sheet")
        }
      }

    }
  }
}

struct ProfileViewSheet_Previews: PreviewProvider {
    static var previews: some View {
      ProfileViewSheet()
    }
}
