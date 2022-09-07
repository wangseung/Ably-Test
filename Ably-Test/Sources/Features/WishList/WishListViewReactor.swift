//
//  WishListViewReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import ReactorKit

final class WishListViewReactor: Reactor {
  enum Action {
    case load
  }
  
  enum Mutation {
    case setWishListGoods([Goods])
    case appendGoods(Goods)
    case removeGoods(Goods)
  }
  
  struct State {
    var wishListGoods: [Goods] = []
    var sections: [WishListSection] = []
  }
  
  var initialState: State
  
  let wishListService: WishListServiceType
  let wishListCellReactorFactory: (Goods) -> WishListGoodsCellReactor
  
  init(
    wishListService: WishListServiceType,
    wishListCellReactorFactory: @escaping (Goods) -> WishListGoodsCellReactor
  ) {
    self.initialState = State()
    self.wishListService = wishListService
    self.wishListCellReactorFactory = wishListCellReactorFactory
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return self.wishListService.fetchGoods()
        .map(Mutation.setWishListGoods)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setWishListGoods(let goods):
      state.wishListGoods = goods
      let items = self.makeGoodsSectionItem(with: state.wishListGoods)
      state.sections = [.goods(items)]
      
    case .appendGoods(let goods):
      state.wishListGoods.append(goods)
      let items = self.makeGoodsSectionItem(with: state.wishListGoods)
      state.sections = [.goods(items)]
      
    case .removeGoods(let goods):
      state.wishListGoods.removeAll(where: { $0.id == goods.id })
      let items = self.makeGoodsSectionItem(with: state.wishListGoods)
      state.sections = [.goods(items)]
    }
    return state
  }
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    let fromGoodsEvent = Goods.event.flatMap { [weak self] event in
      self?.mutation(from: event) ?? .empty()
    }
    return Observable.of(mutation, fromGoodsEvent).merge()
  }
  
  func mutation(from event: Goods.Event) -> Observable<Mutation> {
    switch event {
    case .updateLike(let goods, let isLike):
      if isLike {
        return .just(.appendGoods(goods))
      } else {
        return .just(.removeGoods(goods))
      }
    }
  }
  
  func makeGoodsSectionItem(with goods: [Goods]) -> [WishListSectionItem] {
    return goods
      .sorted { $0.id < $1.id }
      .map(self.wishListCellReactorFactory)
      .map(WishListSectionItem.goods)
  }
}
