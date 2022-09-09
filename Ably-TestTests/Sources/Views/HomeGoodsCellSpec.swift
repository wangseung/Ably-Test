//
//  HomeGoodsCellSpec.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/10.
//

import Quick
import Nimble

@testable import Ably_Test

final class HomeGoodsCellSpec: QuickSpec {
  override func spec() {
    var cell: HomeGoodsCell!
    var reactor: HomeGoodsCellReactor!
    var wishListService: StubWishListService!
    
    beforeEach {
      wishListService = StubWishListService()
      reactor = HomeGoodsCellReactor(
        goods: GoodsFixture.goods1,
        wishListService: wishListService
      )
      cell = HomeGoodsCell(frame: .zero)
      cell.reactor = reactor
    }
    
    describe("price and actual price") {
      beforeEach {
        reactor = HomeGoodsCellReactor(
          goods: GoodsFixture.makeGoods(actualPrice: 2000, price: 1000),
          wishListService: wishListService
        )
        cell.reactor = reactor
      }
      it("calculate the discount rate") {
        expect(cell.discountLabel.text) == "50%"
      }
      
      context("when discount rate is 0%") {
        beforeEach {
          reactor = HomeGoodsCellReactor(
            goods: GoodsFixture.makeGoods(actualPrice: 2000, price: 2000),
            wishListService: wishListService
          )
          cell.reactor = reactor
        }
        it("hide discountLabel") {
          expect(cell.discountLabel.isHidden) == true
        }
      }
    }
    
    
    describe("isNew") {
      beforeEach {
        reactor = HomeGoodsCellReactor(
          goods: GoodsFixture.makeGoods(isNew: true),
          wishListService: wishListService
        )
        cell.reactor = reactor
      }
      
      context("when is new") {
        it("show new label") {
          expect(cell.newLabel.isHidden) == false
        }
      }
    }
    
    describe("sellCount") {
      beforeEach {
        reactor = HomeGoodsCellReactor(
          goods: GoodsFixture.makeGoods(sellCount: 12345),
          wishListService: wishListService
        )
        cell.reactor = reactor
      }
      
      it("show sellCount with commas") {
        expect(cell.sellCountLabel.text) == "12,345개 구매중"
      }
      
      context("when sellCount under 10") {
        beforeEach {
          reactor = HomeGoodsCellReactor(
            goods: GoodsFixture.makeGoods(sellCount: 9),
            wishListService: wishListService
          )
          cell.reactor = reactor
        }
        it("hide sellCountLabel") {
          expect(cell.sellCountLabel.isHidden) == true
        }
      }
    }
    
    describe("like button") {
      it("has normal heart") {
        expect(cell.likeButton.imageView?.image) == HomeGoodsCell.Image.heart
      }
      
      context("when goods in wishList") {
        beforeEach {
          var goods = GoodsFixture.makeGoods()
          goods.isLike = true
          reactor = HomeGoodsCellReactor(
            goods: goods,
            wishListService: wishListService
          )
          cell.reactor = reactor
        }
        
        it("change image of likeButton to red heart") {
          expect(cell.likeButton.imageView?.image) == HomeGoodsCell.Image.heartFill
        }
      }
    }
  }
}
