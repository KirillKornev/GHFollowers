//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String? = ""

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .systemPink
        collection.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)

        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollection()
        fetchFollowers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupCollection() {
        view.addSubview(collectionView)
    }

    private func fetchFollowers() {
        NetworkManager.shared.getFollowers(for: userName ?? "", page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers.count)
            case .failure(let error):
                self.presentGFAlertOnMainThred(title: "bad stuff happened", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
}
