//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

final class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignement: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignement
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }

    // MARK: - Private

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
