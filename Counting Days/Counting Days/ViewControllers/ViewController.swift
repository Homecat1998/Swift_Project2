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
    
    var bgColor = UIColor.white
    
    @IBOutlet var myTiles : [TileView]!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    
    @IBAction func isTesting(_ sender: UISwitch) {
        
        if (sender.isOn){
            model.isTest = true
        } else {
            model.isTest = false
            realReset()
        }
        
    }
    
    
    @IBAction func onReset(_ sender: UIBarButtonItem) {
        
        resetAlert( completion: { _ in
            self.realReset()
        })
        

    }
    
    
    func realReset () {
        for i in 0..<myTiles.count {
            myTiles[i].index = model.tilesArray[i].index
            myTiles[i].delegate = self
            model.tilesArray[i].faceUp = false
        }
        
        model.currentHoliday = HolidayType.None
        model.canOpen = 0
        model.isTest = false
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
        view.backgroundColor = model.currentHoliday.color()
        if (model.isTest){
            mySwitch.setOn(true, animated: true)
        } else {
            mySwitch.setOn(false, animated: true)
        }
    }
    
    
    // Navigation Preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HolidayViewSegue" {
        } else if (segue.identifier == "SelectSegue"){
            if let holidaySelectTVC = segue.destination as? HolidaySelectTVC  {
                holidaySelectTVC.delegate = self
            }
        }
    }
    
    
    
    
    // Reset Alert
    
    func resetAlert(completion: @escaping (UIAlertAction) -> Void) {
        
        let alert = UIAlertController(title: NSLocalizedString("str_resetWarning", comment: ""),
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("str_reset", comment: ""),
                                         style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        /*
         **  In this case we need a source for the popover as well, but don't have a handy UIBarButtonItem.
         **  As alternative we therefore use the sourceView/sourceRect combination and specify a rectangel
         **  centered in the view of our viewController.
         */
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func shouldFlip(_ mybutton: TileView, index: Int) -> Bool {
        
        if (model.isFaceUp(index)){
            return false
            
        } else if (model.isTest && index == 23){
            self.performSegue(withIdentifier: "HolidayViewSegue", sender: self)
            return true;
            
        } else if (model.isTest) {
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
        if model.canOpen > index {
            model.tilesArray[index].faceUp = true
        } else {
            model.tilesArray[index].faceUp = true
            model.canOpen = index + 1
        }

        updateAll()
    }
    
}


extension ViewController : HSTVCDelegate {
    
    func didSelect(_ holidayType: HolidayType) {
        print("Did select!")
        model.currentHoliday = holidayType
        updateAll()
    }
    
    
}

