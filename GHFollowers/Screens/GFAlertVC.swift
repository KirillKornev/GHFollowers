//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

private extension CGFloat {
    static let titlePadding: CGFloat = 20
}

final class GFAlertVC: UIViewController {

    private lazy var container = UIView()
    private lazy var titleLabel = GFTitleLabel(textAlignement: .center, fontSize: 20)
    private lazy var messageLabel = GFBodyLabel(textAlignement: .center)
    private lazy var actionButton = GFButton(backgroundColor: .systemPink, title: "OK")

    var alertTitle: String = ""
    var message: String = ""
    var buttonTitle: String = ""

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)

        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureConteinerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    // MARK: - Private

    private func configureConteinerView() {
        view.addSubview(container)
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.white.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 280),
            container.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    private func configureTitleLabel() {
        container.addSubview(titleLabel)
        titleLabel.text = alertTitle

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: .titlePadding),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .titlePadding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -.titlePadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func configureActionButton() {
        container.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -.titlePadding),
            actionButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .titlePadding),
            actionButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -.titlePadding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    private func configureMessageLabel() {
        container.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .titlePadding),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -.titlePadding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
}
