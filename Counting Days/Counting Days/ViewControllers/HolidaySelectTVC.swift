//
//  HolidaySelectTVC.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/28/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

enum HolidayType: Int, Codable {
    case Halloween, Christmas, Thanksgiving
    static let allValues = [Halloween, Christmas, Thanksgiving]
    
    // return background color for different holiday
    func color() -> UIColor {
        switch self {
        case .Halloween:      return UIColor(red: 0.8, green: 0.4, blue: 0, alpha: 1.0)
        case .Christmas:    return UIColor(red: 0.302, green: 0.6471, blue: 0, alpha: 1.0)
        case .Thanksgiving:     return UIColor(red: 0, green: 0.5059, blue: 0.6588, alpha: 1.0)
        }
    }
    
    // return holiday title
    func title() -> String {
        
        switch self {
        case .Halloween:         return NSLocalizedString("str_halloween", comment: "").capitalized
        case .Christmas:         return NSLocalizedString("str_christmas", comment: "")
        case .Thanksgiving:         return NSLocalizedString("str_thanksgiving", comment: "")
        }

    }
    
}

protocol HSTVCDelegate : class  {
    func didSelect (_ holidayType : HolidayType)
}

class HolidaySelectTVC: UITableViewController {
   
    weak var delegate: HSTVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HolidayType.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select")
        if let type = HolidayType(rawValue: indexPath.row){
            print(type)
            delegate?.didSelect(type)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseIdentifier") as? myTableViewCell else {
            fatalError("Expected TableCell")
        }
        
        cell.holidayLabel.text = HolidayType(rawValue: indexPath.row)?.title()
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


