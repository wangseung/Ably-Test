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
  }
  
  struct State {
    var banners: [Banner] = []
    var goods: [Goods] = []
    var lastID: Int? = nil
    var sections: [HomeViewSection] = []
  }
  
  var initialState = State()
  
  let homeService: HomeServiceType
  
  init(homeService: HomeServiceType) {
    self.homeService = homeService
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      let fetchHome = self.homeService.fetchHome()
        .asObservable()
        .map { response -> Mutation in
          .setHomeResponse(response)
        }
      return fetchHome
      
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
        .goods([.goods])
      ]
      
    case .appendGoods(let goods):
      state.goods += goods
      let abc = goods.map { _ in HomeViewSectionItem.goods }
      let items = state.sections[0].items + abc
      state.sections[1] = .goods(items)
    }
    
    return state
  }
  
  func makeBannerSectionItem(with banners: [Banner]) -> HomeViewSectionItem {
    let bannerContainerReactor = BannerContainerCellReactor(banners: banners)
    let bannerItem = HomeViewSectionItem.banner(bannerContainerReactor)
    return bannerItem
  }
}
