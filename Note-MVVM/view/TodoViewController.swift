//
//  ViewController.swift
//  Note-MVVM
//
//  Created by Nguyễn  Mạnh Đức on 9/18/18.
//  Copyright © 2018 Nguyễn  Mạnh Đức. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoViewController: UIViewController {
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var textFieldAdd: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = TodoViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        
        textFieldAdd.rx.text.map { $0 ?? ""}.bind(to: viewModel.content).disposed(by: disposeBag)
        
        viewModel.content.asObservable().subscribe(onNext: { (value) in
            self.buttonAdd.isEnabled = !value.isEmpty
        })
            .disposed(by: disposeBag)
        
        viewModel.arrTodo.asObservable().subscribe(onNext: { (value) in
            self.tableView.reloadData()
        })
            .disposed(by: disposeBag)
        
        buttonAdd.rx.tap.bind {
            self.viewModel.addNewData(content: self.textFieldAdd.text)
            self.textFieldAdd.text = ""
            }.disposed(by: disposeBag)
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrTodo.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "TodoTableViewCell"
        let cell: TodoTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TodoTableViewCell
        cell.setData(model: viewModel.arrTodo.value[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in success(true)
            self.viewModel.deleteRow(position: indexPath.row)
        })
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            self.showDialog(position: indexPath.row)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    
    func showDialog(position: Int) {
        let alert = UIAlertController(title: "Edit note",
                                      message: "Enter something here to edit",
                                      preferredStyle: .alert)
        // Submit button
        let submitAction = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let content = alert.textFields![0]
            self.viewModel.editNote(position: position, content: content.text ?? "")
        })
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Type something here"
            textField.clearButtonMode = .whileEditing
            textField.text = self.viewModel.arrTodo.value[position].content
        }
        
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

