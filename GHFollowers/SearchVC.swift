//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let userNameTexrField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Private

    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureTextField() {
        view.addSubview(userNameTexrField)

        NSLayoutConstraint.activate([
            userNameTexrField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTexrField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTexrField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTexrField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureCallToActionButton() {
        view.addSubview(callToActionButton)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
