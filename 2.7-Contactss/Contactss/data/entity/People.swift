//
//  Persons.swift
//  Contactss
//
//  Created by Burak Köstekli on 24.11.2023.
//

import Foundation

class People {
    var person_id:Int?
    var person_name:String?
    var person_num:String?
    
    init() {
        
    }
    
    init(person_id: Int, person_name: String, person_num: String) {
        self.person_id = person_id
        self.person_name = person_name
        self.person_num = person_num
    }
    
    
}
