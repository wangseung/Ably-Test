//
//  StubWishListService.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Stub
import RxSwift

@testable import Ably_Test

class StubWishListService: WishListServiceType {
  @StubProxy(fetchGoods) var fetchGoodsStub
  func fetchGoods() -> Observable<[Goods]> {
    fetchGoodsStub.invoke(default: .just([GoodsFixture.goods1, GoodsFixture.goods3, GoodsFixture.goods6]))
  }
  
  func addGoods(_ goods: Goods) -> Observable<Void> {
    return .just(())
  }
  
  func removeGoods(_ goods: Goods) -> Observable<Void> {
    return .just(())
  }
}
