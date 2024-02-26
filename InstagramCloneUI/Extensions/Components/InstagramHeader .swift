//
//  InstagramHeader .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 4.10.2023.
//

import SwiftUI

struct MyNavigationViewToolbar: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ToolbarItem(placement: .navigationBarLeading) {
            if colorScheme == .light {
                Image("Instagramlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 80, alignment: .leading)
            } else if colorScheme == .dark {
                Image("InstagramFontDarkMode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 80, alignment: .leading)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
