//
//  GoodsFixture.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Foundation

@testable import Ably_Test

struct GoodsFixture {
  static let goods1: Goods = fixture(from: [
    "id": 21,
    "name": "페미닌 셔링 퍼프 셔츠 블라우스",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210227_1614430769055229s.gif",
    "is_new": false,
    "sell_count": 431,
    "actual_price": 50000,
    "price": 20000
  ])
}
