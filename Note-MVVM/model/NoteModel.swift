//
//  NoteModel.swift
//  Note-MVVM
//
//  Created by Nguyễn  Mạnh Đức on 9/19/18.
//  Copyright © 2018 Nguyễn  Mạnh Đức. All rights reserved.
//

import Realm
import RealmSwift

class NoteModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var createdAt: Date = Date()
    
    convenience init(id: String, content: String) {
        self.init()
        self.id = id
        self.content = content
        self.createdAt = Date()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
