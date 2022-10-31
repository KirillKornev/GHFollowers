//
//  DataSourceItems.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 23.10.2022.
//

import Foundation

extension FollowerListVC {

    enum Section {
        case main
    }

    enum Item: Hashable {
        case follower(Follower)
    }
}
