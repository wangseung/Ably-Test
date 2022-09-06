//
//  HomeViewSection.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import RxDataSources

enum HomeViewSection {
  case banner([Item])
  case goods([Item])
}

enum HomeViewSectionItem {
  case banner(BannerContainerCellReactor)
  case goods
}

extension HomeViewSection: SectionModelType {
  typealias Item = HomeViewSectionItem
  
  var items: [HomeViewSectionItem] {
    switch self {
    case .banner(let items):
      return items
    case .goods(let items):
      return items
    }
  }
  
  init(original: HomeViewSection, items: [HomeViewSectionItem]) {
    self = original
    switch original {
    case .banner(let items):
      self = .banner(items)
    case .goods(let items):
      self = .goods(items)
    }
  }
}
