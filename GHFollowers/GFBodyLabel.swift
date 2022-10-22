//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

final class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignement: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignement
        configure()
    }

    // MARK: - Private

    private func configure() {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping

        translatesAutoresizingMaskIntoConstraints = false
    }
}
