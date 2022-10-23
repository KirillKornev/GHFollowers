//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        NetworkManager.shared.getFollowers(for: userName ?? "", page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers.count)
            case .failure(let error):
                self.presentGFAlertOnMainThred(title: "bad stuff happened", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
