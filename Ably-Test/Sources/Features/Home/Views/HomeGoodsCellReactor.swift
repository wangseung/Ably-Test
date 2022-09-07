//
//  HomeGoodsCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import ReactorKit

class HomeGoodsCellReactor: Reactor {
  enum Action {
    case toggleLike
  }
  
  enum Mutation {
    case setLike(Bool)
  }
  
  struct State {
    var goods: Goods
    var isLiked: Bool = false
  }
  
  var initialState: State
  
  init(goods: Goods) {
    self.initialState = State(goods: goods)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleLike:
      let toggleLike = !self.currentState.isLiked
      return .just(.setLike(toggleLike))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setLike(let isLiked):
      state.isLiked = isLiked
    }
    return state
  }
}
