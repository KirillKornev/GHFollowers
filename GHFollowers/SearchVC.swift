//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

class SearchVC: UIViewController {

    private lazy var logoImageView = UIImageView()
    private lazy var userNameTexrField = GFTextField()
    private lazy var callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get followers")

    private var isUsernameEntered: Bool {
        let text = userNameTexrField.text ?? ""
        return !text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardGestureRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    func createDismissKeyboardGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc func pushFollowerListVC() {
        guard isUsernameEntered else { print("user name"); return }

        let followerList = FollowerListVC()
        followerList.userName = userNameTexrField.text
        followerList.title = userNameTexrField.text
        navigationController?.pushViewController(followerList, animated: true)
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
        userNameTexrField.delegate = self

        NSLayoutConstraint.activate([
            userNameTexrField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTexrField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTexrField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTexrField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
