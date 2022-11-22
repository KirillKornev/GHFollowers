//
//  GFAvatarImageVIew.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 23.10.2022.
//

import UIKit

final class GFAvatarImageVIew: UIImageView {

    private let cache = NetworkManager.shared.cache
    private lazy var placeholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func downloadImage(from url: String) {

        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        guard let url = URL(string: url) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }

    // MARK: - Private

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
