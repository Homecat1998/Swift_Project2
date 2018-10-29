//
//  AppDelegate.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var FileName = "CountingDaysFile"
    var model = Model()
    
    lazy var fileURL: URL = {
        let documentsDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(FileName, isDirectory: false)
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadData()
        
        if let naviController = window?.rootViewController as? UINavigationController {
            if let mainViewController = naviController.viewControllers.last as? ViewController {
                mainViewController.model = model
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        saveData()
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK - Persistence Methods
    
    func saveData() {

        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                fatalError(error.localizedDescription)
            }
        }

        if let encodedData = try? JSONEncoder().encode(model) {
            FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil)
        } else {
            fatalError("Couldn't write data!")
        }
    }

    func loadData() {

        if !FileManager.default.fileExists(atPath: fileURL.path) {
            model = Model()
            return
        }

        if let jsondata = FileManager.default.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            do {
                let modelRead = try decoder.decode(Model.self, from: jsondata)
                model = modelRead
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(fileURL.path)!")
        }
    }


}

