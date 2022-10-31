//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 01.11.2022.
//

import UIKit

struct UIHelper {

    static func flowLayout(in view: UIView) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3

        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)


        return layout
    }
}
