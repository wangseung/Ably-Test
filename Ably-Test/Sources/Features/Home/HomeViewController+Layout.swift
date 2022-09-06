//
//  HomeViewController+CollectionViewLayout.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import UIKit

extension HomeViewController {
  func collectionViewLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { index, env in
      switch index {
      case 0:
        return self.bannerLayout()
      case 1:
        return self.goodsLayout()
      default:
        fatalError("Invalid index")
      }
    }
  }
  
  private func bannerLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
    
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
  
  private func goodsLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
    
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
}
