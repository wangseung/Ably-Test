//
//  AblyNetworing.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Moya
import RxMoya
import RxSwift

typealias AblyNetworing = Networking<AblyAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {
  func request(_ target: Target) -> Single<Response> {
    return self.rx.request(target)
  }
}
