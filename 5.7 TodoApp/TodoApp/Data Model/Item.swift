//
//  Item.swift
//  TodoApp
//
//  Created by Burak Köstekli on 25.10.2024.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date? 
    
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
}







