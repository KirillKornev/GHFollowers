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
    private var filteredFolloers: [Follower] = []
    private var page = 1
    private var hasMoreFollowers = true

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
        collection.delegate = self
        collection.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)

        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollection()
        configureSearchController()
        fetchFollowers(page: page)
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

    private func fetchFollowers(page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName ?? "", page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()

                switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)

                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers. Go follow them 😄"
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                    self.updateData(on: self.followers)
                case .failure(let error):
                    self.presentAlert(title: "Bad stuff happened", message: error.rawValue , buttonTitle: "Ok")
                }
            }
        }
    }

    private func updateData(on followers: [Follower]) {
        let items: [Item] = followers.map { .follower($0) }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for user name"
        navigationItem.searchController = searchController
    }
}

// MARK: - UICollectionViewDelegate

extension FollowerListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offset > contentHeight - height, hasMoreFollowers {
            page += 1
            fetchFollowers(page: page)
        }
    }
}

// MARK: - UISearchResultsUpdating

extension FollowerListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }

        filteredFolloers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFolloers)
    }
}

// MARK: - UISearchControllerDelegate

extension FollowerListVC: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
