//
//  HomeResponseFixture.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

@testable import Ably_Test

struct HomeResponseFixture {
  static func homeResponse(
    banners: [Banner] = [BannerFixture.banner1, BannerFixture.banner2],
    goods: [Goods] = [GoodsFixture.goods1, GoodsFixture.goods2, GoodsFixture.goods3]
  ) -> HomeResponse {
    HomeResponse(banners: banners, goods: goods)
  }
}
