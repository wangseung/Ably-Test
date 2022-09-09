//
//  HomeViewReactorSpec.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Stub
import Quick
import Nimble
import RxSwift

@testable import Ably_Test

final class HomeViewReactorSpec: QuickSpec {
  override func spec() {
    var reactor: HomeViewReactor!
    var homeService: StubHomeService!
    var wishListService: StubWishListService!
    
    beforeEach {
      homeService = StubHomeService()
      wishListService = StubWishListService()
      reactor = HomeViewReactor(
        homeService: homeService,
        wishListService: wishListService,
        homeGoodsCellReactorFactory: { goods in
          HomeGoodsCellReactor(goods: goods, wishListService: wishListService)
        }
      )
    }
    
    
    context("when called load action") {
      it("fetch homeResponse and wishList") {
        expect(reactor.currentState.goods.isEmpty) == true
        
        reactor.action.onNext(.load)
        
        expect(homeService.fetchHomeStub.executions().count) == 1
        expect(wishListService.fetchGoodsStub.executions().count) == 1
        expect(reactor.currentState.goods.isEmpty) == false
        expect(reactor.currentState.wishListGoods.isEmpty) == false
      }
    }
    
    context("when called more load action") {
      it("append goods") {
        reactor.action.onNext(.load)
        expect(reactor.currentState.goods.count) == 3
        
        reactor.action.onNext(.loadMoreGoods)
        expect(reactor.currentState.goods.count) == 6
      }
    }
    
    context("when called refresh action") {
      it("refresh goods") {
        reactor.action.onNext(.load)
        expect(reactor.currentState.goods.count) == 3
        
        reactor.action.onNext(.loadMoreGoods)
        expect(reactor.currentState.goods.count) == 6
        
        reactor.action.onNext(.refresh)
        expect(reactor.currentState.goods.count) == 3
      }
    }
    
    context("when has liked goods") {
      beforeEach {
        let homeResponse = HomeResponse(
          banners: [],
          goods: [GoodsFixture.goods1, GoodsFixture.goods2]
        )
        let wishListGoods = [GoodsFixture.goods1]
        
        homeService.fetchHomeStub
          .register { .just(homeResponse) }
        
        wishListService.fetchGoodsStub
          .register { .just(wishListGoods) }
      }
      it("change isLike") {
        reactor.action.onNext(.load)
        expect(reactor.currentState.goods[0].isLike) == true
        expect(reactor.currentState.goods[1].isLike) == false
      }
    }
    
    context("when liked goods in load more result") {
      beforeEach {
        let homeResponse = HomeResponse(
          banners: [],
          goods: [GoodsFixture.goods1, GoodsFixture.goods2]
        )
        let moreResponse = [GoodsFixture.goods4]
        let wishListGoods = [GoodsFixture.goods1, GoodsFixture.goods4]
        
        homeService.fetchHomeStub
          .register { .just(homeResponse) }
        
        homeService.fetchMoreGoodsStub
          .register { _ in
            .just(moreResponse)
          }
        wishListService.fetchGoodsStub
          .register { .just(wishListGoods) }
      }
      
      it("change isLike") {
        expect(reactor.currentState.wishListGoods.count) == 0
        reactor.action.onNext(.load)
        expect(reactor.currentState.wishListGoods.count) == 2
        reactor.action.onNext(.loadMoreGoods)
        expect(reactor.currentState.goods.count) == 3
        expect(reactor.currentState.goods[2].isLike) == true
      }
    }
    
    
    context("when load more result is empty") {
      beforeEach {
        let homeResponse = HomeResponse(
          banners: [],
          goods: [GoodsFixture.goods1, GoodsFixture.goods2]
        )
        let moreResponse = [Goods]()
        let wishListGoods = [GoodsFixture.goods1, GoodsFixture.goods4]
        
        homeService.fetchHomeStub
          .register { .just(homeResponse) }
        
        homeService.fetchMoreGoodsStub
          .register { _ in
            .just(moreResponse)
          }
        wishListService.fetchGoodsStub
          .register { .just(wishListGoods) }
      }
      
      it("no more fetch") {
        reactor.action.onNext(.load)
        reactor.action.onNext(.loadMoreGoods)
        expect(homeService.fetchMoreGoodsStub.executions().count) == 1
        expect(reactor.currentState.lastID) == nil
        
        reactor.action.onNext(.loadMoreGoods)
        expect(homeService.fetchMoreGoodsStub.executions().count) == 1
      }
    }
  }
}
