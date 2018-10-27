//
//  MyButton.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import Foundation
import UIKit

class MyButton: UIButton {
    
    
    
    var index = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
}
