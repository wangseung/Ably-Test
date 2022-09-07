//
//  RealmManager.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import RealmSwift

enum RealmError: Error {
  case notFoundObject
}

class RealmManager {
  func save<T: Persistable>(_ value: T) {
    let realm = self.getRealm()
    try? realm.write {
      realm.add(value.toManagedObject(), update: .all)
    }
  }
  
  func remove<T: Object>(value: T) {
    let realm = self.getRealm()
    
    realm.refresh()
    try? realm.write {
      realm.delete(value)
    }
  }
  
  func object<T: Object>(_ type: T.Type, key: Any) -> T? {
    let realm = self.getRealm()
    return realm.object(ofType: type, forPrimaryKey: key)
  }
  
  func objects<T: Object>(objectType: T.Type) -> [T] {
    let realm = self.getRealm()
    let objects = realm.objects(T.self)
    return objects.compactMap { $0 }
  }
  
  private func getRealm() -> Realm {
    return try! Realm()
  }
}
