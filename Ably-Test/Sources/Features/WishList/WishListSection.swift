//
//  WishListSection.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import RxDataSources

enum WishListSection: Equatable {
  case goods([Item])
}

enum WishListSectionItem: Equatable {
  case goods(WishListGoodsCellReactor)
}

extension WishListSection: SectionModelType {
  typealias Item = WishListSectionItem
  
  var items: [WishListSectionItem] {
    switch self {
    case .goods(let items):
      return items
    }
  }
  
  init(original: WishListSection, items: [WishListSectionItem]) {
    self = original
    switch original {
    case .goods(let items):
      self = .goods(items)
    }
  }
}

