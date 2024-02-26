//
//  Service.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 17.10.2023.
//

import Foundation

protocol NetworkService {
  var type : String {get}

  func loadUserData()

}
