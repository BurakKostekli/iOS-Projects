//
//  Category.swift
//  TodoApp
//
//  Created by Burak Köstekli on 25.10.2024.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var color: String = ""
    @Persisted var items = List<Item>()
}

