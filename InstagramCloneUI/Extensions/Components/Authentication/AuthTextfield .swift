//
//  AuthTextfield .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 11.10.2023.
//

import SwiftUI

struct AuthTextfieldBar: View {
  @Binding var usernameTextfield : String
  @Binding var passwordTextfield : String
    var body: some View {
      TextField("Username", text: $usernameTextfield)
        .textInputAutocapitalization(.never)
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal,20)
      SecureField("Password", text: $passwordTextfield)
        .textInputAutocapitalization(.never)
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal,20)

    }
}

struct AuthTextfieldBar_Previews: PreviewProvider {
    static var previews: some View {
      AuthTextfieldBar(usernameTextfield: .constant(""), passwordTextfield: .constant(""))
    }
}
