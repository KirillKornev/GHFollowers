//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.11.2022.
//

import UIKit

final class GFEmptyStateView: UIView {

    // UI
    private lazy var messageLabel = GFTitleLabel(textAlignement: .center, fontSize: 28)
    private lazy var logoView = UIImageView()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(messageLabel)
        addSubview(logoView)

        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        logoView.image = UIImage(named: "empty-state-logo")
        logoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            logoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 60)
        ])
    }
}
