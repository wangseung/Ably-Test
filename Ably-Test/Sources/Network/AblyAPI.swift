//
//  AblyAPI.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

import Moya

enum AblyAPI {
  case fetchHome
  case fetchMoreGoods(lastID: Int)
}

extension AblyAPI: TargetType {
  var baseURL: URL {
    guard let urlString = Bundle.value(for: .apiURL) else {
      fatalError("Failed to load bundle value for apiURL")
    }
    guard let url = URL(string: urlString) else {
      fatalError("Failed to parse url from url string")
    }
    return url
  }
  
  var path: String {
    switch self {
    case .fetchHome:
      return "/home"
    case .fetchMoreGoods:
      return "/home/goods"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case .fetchHome:
      return .requestPlain
      
    case let .fetchMoreGoods(lastID):
      return .requestParameters(
        parameters: ["lastId": lastID],
        encoding: URLEncoding.queryString
      )
    }
  }
  
  var headers: [String : String]? {
    return ["Accept": "application/json"]
  }
}
