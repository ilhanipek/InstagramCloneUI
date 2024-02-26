//
//  TryApi.swift
//  InstagramCloneUI
//
//  Created by ilhan serhan ipek on 23.10.2023.
//

import Foundation


struct PostModel : Codable {

}
protocol ApıServiceProtocol {
    func fethcAllPosts(onSuccess:@escaping ([PostModel]) -> Void, @escaping onFail: (String?) -> Void )
    }

struct ApıService: ApıServiceProtocol {
    func fethcAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: (String?) -> Void) {
        AF.request("",method: .get).validate().responseDecodable(of: [PostModel].self) {
            (response) in

            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
