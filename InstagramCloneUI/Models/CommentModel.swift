//
//  CommentModel.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 5.12.2023.
//

import Foundation

struct Comment: Identifiable, Hashable, Codable {
  let id: String
  let owneruid : String
  let text : String
  let likes : [String]
}
