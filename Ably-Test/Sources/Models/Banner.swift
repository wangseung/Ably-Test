//
//  Banner.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

struct Banner: Codable {
  let id: Int
  let image: String
}

extension Banner {
  var imageURL: URL? {
    return URL(string: image)
  }
}
