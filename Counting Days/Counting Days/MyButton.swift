//
//  MyButton.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import Foundation
import UIKit

protocol EmojiTileViewDelegate: class  {
    func shouldFlip(_ mybutton: MyButton, index: Int) -> Bool
    func didFlip(_ mybutton: MyButton, index: Int)
}

class MyButton: UIButton {
    
    weak var delegate: EmojiTileViewDelegate?
    
    
    
    var index = 0
    
    func animateFlipBack() {
        UIButton.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromRight],
            animations: {
        })
    }
    
    func animateFlip() {
        UIButton.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.delegate?.didFlip(self, index: self.index)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    
}
