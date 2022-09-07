//
//  HomeGoodsCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import ReactorKit

final class HomeGoodsCellReactor: Reactor, IdentityEquatable {
  enum Action {
    case toggleLike
  }
  
  enum Mutation {
    case setLike(Bool)
  }
  
  struct State {
    var goods: Goods
  }
  
  var initialState: State
  
  let wishListService: WishListServiceType
  
  init(goods: Goods, wishListService: WishListServiceType) {
    self.initialState = State(goods: goods)
    self.wishListService = wishListService
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleLike:
      let isLike = !self.currentState.goods.isLike
      if isLike {
        return self.wishListService.addGoods(self.currentState.goods)
          .map { Mutation.setLike(true) }
      } else {
        return self.wishListService.removeGoods(self.currentState.goods.id)
          .map { Mutation.setLike(false) }
      }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setLike(let isLiked):
      state.goods.isLike = isLiked
    }
    return state
  }
}
