//
//  ModelType.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import RxSwift

struct NoEvent { }

private var streams: [String: Any] = [:]

protocol ModelType {
  associatedtype Event
}

extension ModelType {
  static var event: PublishSubject<Event> {
    let key = String(describing: self)
    if let stream = streams[key] as? PublishSubject<Event> {
      return stream
    }
    let stream = PublishSubject<Event>()
    streams[key] = stream
    return stream
  }
}
