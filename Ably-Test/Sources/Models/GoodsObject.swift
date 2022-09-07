//
//  GoodsObject.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import Foundation
import RealmSwift

class GoodsObject: Object {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var name: String
  @Persisted var image: String
  @Persisted var actualPrice: Int
  @Persisted var price: Int
  @Persisted var isNew: Bool
  @Persisted var sellCount: Int
}
