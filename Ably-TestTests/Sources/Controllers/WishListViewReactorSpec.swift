//
//  WishListViewReactorSpec.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/09.
//

import Stub
import Quick
import Nimble
import RxSwift

@testable import Ably_Test

final class WishListViewReactorSpec: QuickSpec {
  override func spec() {
    var reactor: WishListViewReactor!
    var wishListService: StubWishListService!
    
    
    beforeEach {
      wishListService = StubWishListService()
      
      reactor = WishListViewReactor(
        wishListService: wishListService,
        wishListCellReactorFactory: { goods in
          WishListGoodsCellReactor(goods: goods)
        }
      )
    }
    
    context("when called load action") {
      it("fetch wish list goods") {
        reactor.action.onNext(.load)
        
        expect(wishListService.fetchGoodsStub.executions().count) == 1
        expect(reactor.currentState.wishListGoods.count) == 3
      }
    }
  }
}
