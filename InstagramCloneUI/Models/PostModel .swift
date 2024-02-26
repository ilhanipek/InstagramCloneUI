//
//  PostModel .swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 14.10.2023.
//

import Foundation
import Firebase
class Like : ObservableObject {
  @Published var isLiked = false
}

struct Post : Identifiable, Hashable, Codable {
  let id : String
  let owneruid : String
  let caption : String
  var likes: [String] //
  var comment : [Comment]?
  let imageUrl: String
  let timeStamp: Timestamp
  var user: User?
}

extension Post {
    func timeFromTimestamp() -> String {
        let currentDate = Date()
        let postDate = self.timeStamp.dateValue()
        let diff = Calendar.current.dateComponents([.hour, .minute], from: postDate, to: currentDate)

        if let hours = diff.hour, hours > 0 {
            if hours == 1 { 
                return "\(hours) hour ago"
            } else {
                return "\(hours) hour ago"
            }
        } else if let minutes = diff.minute, minutes > 0 {
            return "\(minutes) minute ago"
        } else {
            return "Now"
        }
    }
}

extension Post {
  static var posts: [Post] = [
    .init(id: NSUUID().uuidString, owneruid: NSUUID().uuidString, caption: "DestiCaption", likes: [""], imageUrl: "desti3", timeStamp: Timestamp(), user: User.users[0]),
    .init(id: NSUUID().uuidString, owneruid: NSUUID().uuidString, caption: "IlhanCaption", likes: [""], imageUrl: "ironmaiden", timeStamp: Timestamp(), user: User.users[1]),
    .init(id: NSUUID().uuidString, owneruid: NSUUID().uuidString, caption: "EdoCaption", likes: [""], imageUrl: "darkknight", timeStamp: Timestamp(), user: User.users[2])
  ]

}
