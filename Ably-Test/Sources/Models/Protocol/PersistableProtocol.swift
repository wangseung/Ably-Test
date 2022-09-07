//
//  Persistable.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import RealmSwift

protocol Persistable {
  associatedtype ManagedObject: RealmSwift.Object

  init(from managedObject: ManagedObject)
  
  func toManagedObject() -> ManagedObject
}
