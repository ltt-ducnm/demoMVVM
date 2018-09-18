//
//  TodoTableViewCell.swift
//  Note-MVVM
//
//  Created by Nguyễn  Mạnh Đức on 9/19/18.
//  Copyright © 2018 Nguyễn  Mạnh Đức. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model: NoteModel) {
        nameLabel.text = model.content
    }
}
