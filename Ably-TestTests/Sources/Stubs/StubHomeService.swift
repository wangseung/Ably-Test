//
//  StubHomeService.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Stub
import RxSwift

@testable import Ably_Test

class StubHomeService: HomeServiceType {
  @StubProxy(fetchHome) var fetchHomeStub
  func fetchHome() -> Single<HomeResponse> {
    fetchHomeStub.invoke(default: Single.just(HomeResponseFixture.homeResponse()))
  }
  
  @StubProxy(fetchMoreGoods) var fetchMoreGoodsStub
  func fetchMoreGoods(with lastID: Int) -> Single<[Goods]> {
    fetchMoreGoodsStub.invoke(lastID, default: Single.just([GoodsFixture.goods1, GoodsFixture.goods2, GoodsFixture.goods3]))
  }
}
