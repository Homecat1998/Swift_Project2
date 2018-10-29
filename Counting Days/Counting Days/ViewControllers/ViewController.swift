//
//  ViewController.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegate{
    
    
    var model = Model()
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    var isTest = false
    
    var bgColor = UIColor.white
    
    @IBOutlet var myTiles : [TileView]!
    

    @IBOutlet weak var selectBtn: UIBarButtonItem!
    
    @IBAction func isTesting(_ sender: UISwitch) {
        
        isTest = sender.isOn
    }
    
    
    @IBAction func onReset(_ sender: UIBarButtonItem) {
        
        for i in 0..<myTiles.count {
            myTiles[i].index = model.tilesArray[i].index
            myTiles[i].delegate = self
            model.tilesArray[i].faceUp = false
        }
        
        
        model.canOpen = 0;
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
        
        selectBtn.title = NSLocalizedString("str_selectHoliday", comment: "")
        testLabel.text = NSLocalizedString("str_test", comment: "")
        
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
        genereteColor(colorInt: model.bgColor)
        view.backgroundColor = bgColor
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HolidayViewSegue" {
        } else if (segue.identifier == "SelectSegue"){
            if let holidaySelectTVC = segue.destination as? HolidaySelectTVC  {
                holidaySelectTVC.delegate = self
            }
        }
    }
    
    
    func genereteColor(colorInt : Int) {
        if (model.bgColor == 0) {
            bgColor = UIColor.white
        } else if (model.bgColor == 1){
            bgColor = UIColor.brown
        } else if (model.bgColor == 2){
            bgColor = UIColor.green
        } else if (model.bgColor == 3){
            bgColor = UIColor.orange
        }
    }
    
    
    func setColorToModel(color : UIColor){
        if (color == UIColor.white) {
            model.bgColor = 0
        } else if (color == UIColor.brown){
            model.bgColor = 1
        } else if (color == UIColor.green){
            model.bgColor = 2
        } else if (color == UIColor.orange){
            model.bgColor = 3
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func shouldFlip(_ mybutton: TileView, index: Int) -> Bool {
        
        if (model.isFaceUp(index)){
            return false
            
        } else if (isTest && index == 23){
            self.performSegue(withIdentifier: "HolidayViewSegue", sender: self)
            return true;
            
        } else if (isTest) {
            return true
            
        } else if (model.canOpen < index){
            let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: ""), message: nil,  preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                             style: .cancel, handler:nil)
            
            alert.addAction(cancelAction)
            
            alert.popoverPresentationController?.permittedArrowDirections = []
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
            
            self.present(alert, animated: true)
            
            return false
            
        } else if (index == 23){
            
            self.performSegue(withIdentifier: "HolidayViewSegue", sender: self)
            return true;
            
        } else {
            return true
        }
        
    }
    
    func didFlip(_ mybutton: TileView, index: Int) {
        model.tilesArray[index].faceUp = true
        model.canOpen = index + 1
        updateAll()
    }
    
}


extension ViewController : HSTVCDelegate {
    
    func didSelect(_ holidayType: HolidayType) {
        print("Did select!")
        setColorToModel(color: holidayType.color())
        updateAll()
    }
    
    
}

