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
    case refresh
    case loadMoreGoods
  }
  
  enum Mutation {
    case setWishListGoods([Goods])
    case setHomeResponse(HomeResponse)
    case appendGoods([Goods])
    case setLikeGoods(index: Int, isLike: Bool)
    case setRefreshing(Bool)
    case setFetchingMoreGoods(Bool)
  }
  
  struct State {
    var banners: [Banner] = []
    var goods: [Goods] = []
    var wishListGoods: [Goods] = []
    var lastID: Int? = nil
    var isRefreshing = false
    var isFetchingMoreGoods = false
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
      let wishListGoods = self.wishListService.fetchGoods()
        .map(Mutation.setWishListGoods)
      
      let fetchHome = self.homeService.fetchHome()
        .asObservable()
        .map(Mutation.setHomeResponse)
      return .concat(
        wishListGoods,
        fetchHome
      )
      
    case .refresh:
      guard
        !self.currentState.isRefreshing,
        !self.currentState.isFetchingMoreGoods
      else { return .empty() }
      let refresh = self.homeService.fetchHome()
        .asObservable()
        .map(Mutation.setHomeResponse)
      
      return .concat(
        .just(.setRefreshing(true)),
        refresh,
        .just(.setRefreshing(false))
      )
      
    case .loadMoreGoods:
      guard
        !self.currentState.isRefreshing,
        !self.currentState.isFetchingMoreGoods,
        let lastID = self.currentState.lastID
      else { return .empty() }
      let fetchMoreGoods = self.homeService.fetchMoreGoods(with: lastID)
        .asObservable()
        .map(Mutation.appendGoods)
      
      return .concat(
        .just(.setFetchingMoreGoods(true)),
        fetchMoreGoods,
        .just(.setFetchingMoreGoods(false))
      )
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setWishListGoods(let goods):
      state.wishListGoods = goods
      
    case .setHomeResponse(let response):
      state.banners = response.banners
      state.goods = self.updateLike(goods: response.goods, wishListGoods: state.wishListGoods)
      state.lastID = response.goods.last?.id
      state.sections = [
        .banner([self.makeBannerSectionItem(with: state.banners)]),
        .goods(self.makeGoodsSectionItem(with: state.goods))
      ]
      
    case .appendGoods(let goods):
      if goods.isEmpty {
        state.lastID = nil
        return state
      }
      state.lastID = goods.last?.id
      let goodsWithLike = self.updateLike(goods: goods, wishListGoods: state.wishListGoods)
      state.goods += goodsWithLike
      state.sections[1] = .goods(self.makeGoodsSectionItem(with: state.goods))
      
    case let .setLikeGoods(index, isLike):
      state.goods[index].isLike = isLike
      if isLike {
        state.wishListGoods.append(state.goods[index])
      } else {
        state.wishListGoods.removeAll(where: { $0.id == state.goods[index].id })
      }
      
    case .setRefreshing(let isRefreshing):
      state.isRefreshing = isRefreshing
    
    case .setFetchingMoreGoods(let isFetching):
      state.isFetchingMoreGoods = isFetching
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
      let index = self.currentState.goods.firstIndex(where: { $0.id == goods.id }) ?? 0
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
