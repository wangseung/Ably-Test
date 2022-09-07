//
//  BannerContainerCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import ReactorKit

final class BannerContainerCellReactor: Reactor, IdentityEquatable {
  
  enum Action {
    case move(index: Int)
  }
  
  enum Mutation {
    case setIndex(Int)
  }
  
  struct State {
    var banners: [Banner]
    var indexText: String
  }
  
  var initialState: State
  
  init(banners: [Banner]) {
    self.initialState = State(
      banners: banners,
      indexText: "1/\(banners.count)"
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .move(let index):
      return .just(.setIndex(index + 1))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setIndex(let index):
      state.indexText = "\(index)/\(state.banners.count)"
    }
    
    return state
  }
}
