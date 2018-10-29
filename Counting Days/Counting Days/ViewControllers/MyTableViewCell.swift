//
//  TableViewCell.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/28/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var holidayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
