//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String? = ""
    private(set) var followers: [Follower] = []

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .follower(let follower):
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as? FollowerCell
                else {
                    return UICollectionViewCell()
                }

                cell.set(follower: follower)
                return cell
            }
        }
    }()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.flowLayout(in: view))
        collection.backgroundColor = .systemBackground
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
        NetworkManager.shared.getFollowers(for: userName ?? "", page: 1) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let followers):
                    let items: [Item] = followers.map { .follower($0) }
                    self?.updateData(with: items)
                case .failure(let error):
                    self?.presentAlert(title: "Bad stuff happened", message: error.rawValue , buttonTitle: "Ok")
                }
            }
        }
    }

    private func updateData(with items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}