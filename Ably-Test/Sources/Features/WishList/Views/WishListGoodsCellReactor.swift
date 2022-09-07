//
//  WishListGoodsCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import RxSwift
import ReactorKit

final class WishListGoodsCellReactor: Reactor, IdentityEquatable {
  typealias Action = NoAction
  typealias Mutation = NoMutation
  
  struct State {
    var goods: Goods
  }
  
  var initialState: State
    
  init(goods: Goods) {
    self.initialState = State(goods: goods)
  }
}
