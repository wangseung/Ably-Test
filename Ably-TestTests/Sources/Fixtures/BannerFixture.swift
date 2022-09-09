//
//  BannerFixture.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Foundation

@testable import Ably_Test

struct BannerFixture {
  static let banner1: Banner = fixture(from: [
    "id": 1,
    "image": "https://img.a-bly.com/banner/images/banner_image_1615465448476691.jpg"
  ])
  
  static let banner2: Banner = fixture(from: [
    "id": 2,
    "image": "https://img.a-bly.com/banner/images/banner_image_1615970086333899.jpg"
  ])
}
