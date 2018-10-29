//
//  TileView.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

protocol TileViewDelegate: class  {
    func shouldFlip(_ tileView: TileView, index: Int) -> Bool
    func didFlip(_ tileView: TileView, index: Int)
}

class TileView: UIView {
    
    @IBOutlet weak var label : UILabel!
    
    
    weak var delegate: TileViewDelegate?
    
    var index = 0
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Animations
    
    
    func animateFlip() {
        print(self.index, "get flipped")
        UIView.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.delegate?.didFlip(self, index: self.index)
        })
    }
    
    // MARK: - Gestures
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if (delegate?.shouldFlip(self, index: self.index))! {
            animateFlip()
        }
    }
}
