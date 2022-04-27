//
//  ImagesCollectionViewLayout.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import UIKit

class ImagesCollectionViewLayout{
    static func generateCollectionViewLayout() -> UICollectionViewLayout{
        if #available(iOS 13.0, *) {
            let fullPhotoItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(2/3)))
            fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
              top: 2,
              leading: 2,
              bottom: 2,
              trailing: 2)
            
            let mainItem = NSCollectionLayoutItem(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)))

            mainItem.contentInsets = NSDirectionalEdgeInsets(
              top: 2,
              leading: 2,
              bottom: 2,
              trailing: 2)

            // 2
            let pairItem = NSCollectionLayoutItem(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))

            pairItem.contentInsets = NSDirectionalEdgeInsets(
              top: 2,
              leading: 2,
              bottom: 2,
              trailing: 2)

            let trailingGroup = NSCollectionLayoutGroup.vertical(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)),
              subitem: pairItem,
              count: 2)

            // 1
            let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
              subitems: [mainItem, trailingGroup])
            
            let tripletItem = NSCollectionLayoutItem(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))

            tripletItem.contentInsets = NSDirectionalEdgeInsets(
              top: 2,
              leading: 2,
              bottom: 2,
              trailing: 2)

            let tripletGroup = NSCollectionLayoutGroup.horizontal(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)),
              subitems: [tripletItem, tripletItem, tripletItem])
            
            
            let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
              subitems: [trailingGroup, mainItem])
            
            
            let nestedGroup = NSCollectionLayoutGroup.vertical(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
              subitems: [
                fullPhotoItem,
                mainWithPairGroup,
                tripletGroup,
                mainWithPairReversedGroup
              ]
            )

            let section = NSCollectionLayoutSection(group: nestedGroup)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        } else {
            return UICollectionViewFlowLayout()
        }
    }
}
