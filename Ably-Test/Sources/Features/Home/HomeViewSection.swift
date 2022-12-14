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
  case goods(HomeGoodsCellReactor)
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

extension HomeViewSection: Equatable {
  
}

extension HomeViewSectionItem: Equatable {
  static func == (lhs: HomeViewSectionItem, rhs: HomeViewSectionItem) -> Bool {
    switch(lhs, rhs) {
    case (.banner(let lhs), .banner(let rhs)):
      return lhs == rhs
    case (.goods(let lhs), .goods(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }
}
