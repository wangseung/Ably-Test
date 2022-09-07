//
//  HomeViewReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import RxSwift
import ReactorKit

final class HomeViewReactor: Reactor {
  enum Action {
    case load
    case loadMoreGoods
  }
  
  enum Mutation {
    case setHomeResponse(HomeResponse)
    case appendGoods([Goods])
    case setLikeGoods(index: Int, isLike: Bool)
  }
  
  struct State {
    var banners: [Banner] = []
    var goods: [Goods] = []
    var lastID: Int? = nil
    var sections: [HomeViewSection] = []
  }
  
  var initialState = State()
  
  private let homeService: HomeServiceType
  private let wishListService: WishListServiceType
  private let homeGoodsCellReactorFactory: (Goods) -> HomeGoodsCellReactor
  
  init(
    homeService: HomeServiceType,
    wishListService: WishListServiceType,
    homeGoodsCellReactorFactory: @escaping (Goods) -> HomeGoodsCellReactor
  ) {
    self.homeService = homeService
    self.wishListService = wishListService
    self.homeGoodsCellReactorFactory = homeGoodsCellReactorFactory
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      let fetchHome = self.homeService.fetchHome()
        .asObservable()
      
      let wishListGoods = wishListService.fetchGoods()
      
      return fetchHome
        .withLatestFrom(wishListGoods, resultSelector: { [weak self] homeResponse, wishListGoods -> HomeResponse in
          guard let self = self else { return homeResponse }
          var homeResponse = homeResponse
          homeResponse.goods = self.updateLike(goods: homeResponse.goods, wishListGoods: wishListGoods)
          return homeResponse
        })
        .map { response -> Mutation in
          .setHomeResponse(response)
        }
      
    case .loadMoreGoods:
      guard let lastID = self.currentState.lastID else { return .empty() }
      return self.homeService.fetchMoreGoods(with: lastID)
        .asObservable()
        .map { goods -> Mutation in
          .appendGoods(goods)
        }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setHomeResponse(let response):
      state.banners = response.banners
      state.goods = response.goods
      state.lastID = response.goods.last?.id
      state.sections = [
        .banner([self.makeBannerSectionItem(with: state.banners)]),
        .goods(self.makeGoodsSectionItem(with: state.goods))
      ]
      
    case .appendGoods(let goods):
      state.goods += goods
      let items = state.sections[0].items
      state.sections[1] = .goods(items)
      
    case let .setLikeGoods(index, isLike):
      state.goods[index].isLike = isLike
      state.sections[1] = .goods(self.makeGoodsSectionItem(with: state.goods))
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
    case .updateLike(let id, let isLike):
      let index = self.currentState.goods.firstIndex(where: { $0.id == id }) ?? 0
      return .just(.setLikeGoods(index: index, isLike: isLike))
    }
  }
  
  func makeGoodsSectionItem(with goods: [Goods]) -> [HomeViewSectionItem] {
    return goods
      .map(self.homeGoodsCellReactorFactory)
      .map(HomeViewSectionItem.goods)
  }
  
  func makeBannerSectionItem(with banners: [Banner]) -> HomeViewSectionItem {
    let bannerContainerReactor = BannerContainerCellReactor(banners: banners)
    let bannerItem = HomeViewSectionItem.banner(bannerContainerReactor)
    return bannerItem
  }
  
  func updateLike(goods: [Goods], wishListGoods: [Goods]) -> [Goods] {
    var goodsList = goods
    goodsList.enumerated()
      .forEach { index, goods in
         let isLike = wishListGoods.map { $0.id }.contains(goods.id)
        goodsList[index].isLike = isLike
      }
    return goodsList
  }
}
