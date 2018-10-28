//
//  ViewController.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EmojiTileViewDelegate {

    
    
    var model : Model?
    
    @IBOutlet var tiles: [MyButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        model?.initGame(with: 24)
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0..<tiles.count {
            if let idx = model?.tilesArray[i].index{
                tiles[i].index = idx
                tiles[i].delegate = self
            }
        }
        
        updateAll()
    }
    
    
    func updateAll() {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func shouldFlip(_ mybutton: MyButton, index: Int) -> Bool {
        
        if let up = model?.isFaceUp(index){
            if up {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func didFlip(_ mybutton: MyButton, index: Int) {
        updateAll()
    }
    
    

}

