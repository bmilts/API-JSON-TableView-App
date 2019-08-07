//
//  JSONTableViewCell.swift
//  JSONTableView
//
//  Created by Brendan Milton on 03/08/2019.
//  Copyright © 2019 Brendan Milton. All rights reserved.
//

import UIKit

class JSONTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellDetailText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
