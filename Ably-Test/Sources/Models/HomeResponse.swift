//
//  HomeResponse.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

struct HomeResponse: Codable {
  var banners: [Banner]
  var goods: [Goods]
}
