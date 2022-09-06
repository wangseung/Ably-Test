//
//  HomeService.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

import Moya
import RxSwift

protocol HomeServiceType {
  func fetchHome() -> Single<HomeResponse>
  func fetchMoreGoods(with lastID: Int) -> Single<[Goods]>
}

final class HomeService: HomeServiceType {
  let networking: AblyNetworing
  
  init(networking: AblyNetworing) {
    self.networking = networking
  }
  
  func fetchHome() -> Single<HomeResponse> {
    return self.networking
      .request(.fetchHome)
      .map(HomeResponse.self, using: JSONDecoder())
  }
  
  func fetchMoreGoods(with lastID: Int) -> Single<[Goods]> {
    return self.networking
      .request(.fetchMoreGoods(lastID: lastID))
      .map([Goods].self, atKeyPath: "goods", using: JSONDecoder(), failsOnEmptyData: false)
  }
}
