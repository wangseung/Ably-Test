//
//  Goods.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

struct Goods: Codable, ModelType {
  enum Event {
    case updateLike(goods: Goods, isLike: Bool)
  }
  
  let id: Int
  let name: String
  let image: String
  let actualPrice: Int
  let price: Int
  let isNew: Bool
  let sellCount: Int
  
  var isLike: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case id, name, image, price
    case actualPrice = "actual_price"
    case isNew = "is_new"
    case sellCount = "sell_count"
  }
}

extension Goods {
  var imageURL: URL? {
    URL(string: image)
  }
}
