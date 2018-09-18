//
//  Dbhelper.swift
//  Note-MVVM
//
//  Created by Nguyễn  Mạnh Đức on 9/19/18.
//  Copyright © 2018 Nguyễn  Mạnh Đức. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Dbhelper {
    static let instance = Dbhelper()
    var realm: Realm? = try? Realm()
    
    func addNote(with content: String) -> NoteModel {
        let newNote = NoteModel(id: UUID().uuidString, content: content)
        try? realm?.write {
            realm?.add(newNote)
        }
        return newNote
    }
    
    func deleteNote(with note: NoteModel) {
        try? realm?.write {
            realm?.delete(note)
        }
    }
    
    func editNote(id: String, content: String) -> NoteModel {
        let editNote = NoteModel(id: id, content: content)
        try? realm?.write {
            realm?.add(editNote, update: true)
        }
        return editNote
    }
    
    func getAllNote() -> [NoteModel] {
        guard let listNote = realm?.objects(NoteModel.self)
            .sorted(byKeyPath: "createdAt", ascending: false) else { return [] }
        return Array(listNote)
    }
}
