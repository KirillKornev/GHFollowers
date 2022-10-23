//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 23.10.2022.
//

import UIKit

private extension CGFloat {
    static let padding: CGFloat = 8
}

final class FollowerCell: UICollectionViewCell {

    static let reuseId = "FollowerCell"

    private lazy var avatarImageView = GFAvatarImageVIew(frame: .zero)
    private lazy var userNameLabel = GFTitleLabel(textAlignement: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower: Follower) {
        userNameLabel.text = follower.login
    }

    // MARK: - Private

    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
