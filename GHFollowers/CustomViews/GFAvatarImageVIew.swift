//
//  GFAvatarImageVIew.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 23.10.2022.
//

import UIKit

final class GFAvatarImageVIew: UIImageView {

    private lazy var placeholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
