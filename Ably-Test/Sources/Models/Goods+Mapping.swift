//
//  Goods+Mapping.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import Foundation

extension Goods: Persistable {
  init(from managedObject: GoodsObject) {
    self.id = managedObject.id
    self.name = managedObject.name
    self.image = managedObject.image
    self.actualPrice = managedObject.actualPrice
    self.price = managedObject.price
    self.isNew = managedObject.isNew
    self.sellCount = managedObject.sellCount
  }
  
  func toManagedObject() -> GoodsObject {
    let goods = GoodsObject()
    goods.id = self.id
    goods.name = self.name
    goods.image = self.image
    goods.actualPrice = self.actualPrice
    goods.price = self.price
    goods.isNew = self.isNew
    goods.sellCount = self.sellCount
    return goods
  }
}
