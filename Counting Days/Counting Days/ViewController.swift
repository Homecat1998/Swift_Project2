//
//  ViewController.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegate {

    
    
    var model = Model()
    
    @IBOutlet var myTiles : [TileView]!

    @IBAction func onReset(_ sender: UIBarButtonItem) {
        
        for i in 0..<myTiles.count {
            myTiles[i].index = model.tilesArray[i].index
            myTiles[i].delegate = self
            model.tilesArray[i].faceUp = false
        }

        
        updateAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.initGame(with: 24)
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0..<myTiles.count {
            myTiles[i].index = model.tilesArray[i].index
            myTiles[i].delegate = self
        }
        
        updateAll()
    }
    
    
    func updateAll() {
        for i in 0..<myTiles.count {
            if model.isFaceUp(i) {
                myTiles[i].backgroundColor = .white
                myTiles[i].title = model.emoji(for: i)!
            } else {
                myTiles[i].title = String(model.tilesArray[i].index + 1)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func shouldFlip(_ mybutton: TileView, index: Int) -> Bool {
        
        if (model.isFaceUp(index) || model.canOpen != index){
            let alert = UIAlertController(
                title: NSLocalizedString("str_selectItemToAdd", comment: ""),
                message: nil,
                preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel)

            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            
            return false;
        } else {
            return true;
        }
        
    }
    
    func didFlip(_ mybutton: TileView, index: Int) {
        model.tilesArray[index].faceUp = true
        model.canOpen = index + 1
        updateAll()
    }
    
    

}

