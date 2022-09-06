//
//  BannerCellReactor.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import ReactorKit

final class BannerCellReactor: Reactor {
  typealias Action = NoAction
  typealias Mutation = NoMutation
  
  struct State {
    let banner: Banner
  }
  
  var initialState: State
  
  init(banner: Banner) {
    self.initialState = State(banner: banner)
  }
}
