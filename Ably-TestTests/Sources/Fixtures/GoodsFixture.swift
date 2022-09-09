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
    "id": 1,
    "name": "페미닌 셔링 퍼프 셔츠 블라우스",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210227_1614430769055229s.gif",
    "is_new": false,
    "sell_count": 1200,
    "actual_price": 50000,
    "price": 20000
  ])
  
  static let goods2: Goods = fixture(from: [
    "id": 2,
    "name": "[에뛰드] 블링블링 아이스틱 2개 SET",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210319_1616117488166166s.jpg",
    "is_new": true,
    "sell_count": 10,
    "actual_price": 20000,
    "price": 10000
  ])
  
  static let goods3: Goods = fixture(from: [
    "id": 3,
    "name": "킬커버 광채 파운데이션 미니 15g",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210304_1614821003450471s.jpg",
    "is_new": false,
    "sell_count": 9,
    "actual_price": 15000,
    "price": 7800
  ])
  
  static let goods4: Goods = fixture(from: [
    "id": 4,
    "name": "페미닌 셔링 퍼프 셔츠 블라우스",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210227_1614430769055229s.gif",
    "is_new": false,
    "sell_count": 1200,
    "actual_price": 50000,
    "price": 20000
  ])
  
  static let goods5: Goods = fixture(from: [
    "id": 5,
    "name": "[에뛰드] 블링블링 아이스틱 2개 SET",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210319_1616117488166166s.jpg",
    "is_new": true,
    "sell_count": 10,
    "actual_price": 20000,
    "price": 10000
  ])
  
  static let goods6: Goods = fixture(from: [
    "id": 6,
    "name": "킬커버 광채 파운데이션 미니 15g",
    "image": "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210304_1614821003450471s.jpg",
    "is_new": false,
    "sell_count": 9,
    "actual_price": 15000,
    "price": 7800
  ])
}
