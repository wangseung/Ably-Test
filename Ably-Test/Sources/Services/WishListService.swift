//
//  WishListService.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import RxSwift

protocol WishListServiceType {
  func addGoods(_ goods: Goods) -> Observable<Void>
  func removeGoods(_ goodsID: Int) -> Observable<Void>
  func fetchGoods() -> Observable<[Goods]>
}

final class WishListService: WishListServiceType {
  let realmManager: RealmManager
  
  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }
  
  func addGoods(_ goods: Goods) -> Observable<Void> {
    Observable.create { observer in
      self.realmManager.save(goods)
      observer.onNext(())
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
  
  func removeGoods(_ goodsID: Int) -> Observable<Void> {
    Observable.create { observer in
      guard let object = self.realmManager.object(GoodsObject.self, key: goodsID) else {
        observer.onError(RealmError.notFoundObject)
        return Disposables.create()
      }
      self.realmManager.remove(value: object)
      observer.onNext(())
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
  
  func fetchGoods() -> Observable<[Goods]> {
    Observable.create { observer in
      let objects = self.realmManager.objects(objectType: GoodsObject.self)
      let goods = objects.map { Goods(from: $0) }
      observer.onNext(goods)
      observer.onCompleted()
      return Disposables.create()
    }
  }
}
