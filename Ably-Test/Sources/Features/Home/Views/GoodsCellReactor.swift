//
//  GoodsCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import ReactorKit

class GoodsCellReactor: Reactor {
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
