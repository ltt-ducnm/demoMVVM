//
//  TodoViewModel.swift
//  Note-MVVM
//
//  Created by Nguyễn  Mạnh Đức on 9/19/18.
//  Copyright © 2018 Nguyễn  Mạnh Đức. All rights reserved.
//

import Foundation
import RxSwift

struct TodoViewModel {
    var arrTodo = Variable<[NoteModel]>([])
    var content = Variable<String>("")
    
    init() {
        getListNote()
    }
    
    private func getListNote() {
        arrTodo.value = Dbhelper.instance.getAllNote()
    }
    
    func addNewData(content: String?) {
        let newNote = Dbhelper.instance.addNote(with: content ?? "")
        arrTodo.value.insert(newNote, at: 0)
    }
    
    func deleteRow(position: Int) {
        Dbhelper.instance.deleteNote(with: arrTodo.value[position])
        arrTodo.value.remove(at: position)
    }
    
    func editNote(position: Int, content: String) {
        let editNote = Dbhelper.instance.editNote(id: arrTodo.value[position].id, content: content)
        arrTodo.value[position] = editNote
    }
}
