//
//  Fixture.swift
//  Ably-TestTests
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import Foundation

func fixture<T: Decodable>(from json: [String: Any?]) -> T {
  do {
    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    return try JSONDecoder().decode(T.self, from: data)
  } catch let error {
    fatalError(String(describing: error))
  }
}
