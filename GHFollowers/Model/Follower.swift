//
//  Follower.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import Foundation

struct Follower: Codable {
    let login: String
    let avatarUrl: String
}

extension Follower: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
