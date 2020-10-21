//
//  AppDelegate.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/2/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import Pendo.PendoManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var stationsViewController: StationsViewController?
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        if url.scheme?.range(of: "pendo") != nil {
            PendoManager.shared().initWith(url)
            
            return true
        }
        // your code here...
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
       

        
        
        let initParams = PendoInitParams()
        initParams.visitorId = "CNVisitorID"
        initParams.visitorData = ["key": "value", "Country": "USA", "Gender": "Male"]
        initParams.accountId = "CNAccountID"
        initParams.accountData = ["key": "value", "Timezone": "EST", "Size": "Enterprise"]

        // *************** Aşağıdaki tek satır kodu silebilirsin ********
        PendoManager.shared().track("event_name", properties: ["key1":"val1", "key2":"val2"])

        
        PendoManager.shared().initSDK(
            "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiIxZTg2Y2ZlNTg2YzJiMWQxYjg3MGM1YWQwMDM5ZTIwMTI1YTA2OWZhM2JmMjA0ZDljOWE5ZWQzYjkwZmY5MGZlYTJhODA4ZmNlMmNmNmNkMjVkZTAwZWM2YWFkNmQ4YzcyZDQxYzIyNTU5MzdmZWI0M2NlNDQzMTM2MjY3OWI5ZC4xN2Q2YTliOGE4ODA4OTU3MDliYzVkMWU1NTg1MjllYS42MTAyZThlOWRhMTY5ZDgwYTk2Yzc3MmMxOWJiMzU3NjU3NjJkOTc5ZWM0MjMxMThlZTAzYTRmZDdjYmEzYThkIn0.DnbfTcuON-J3TS4AegxAhTpcpMU_f-XzjySZua0crlz1DrjspVeq6nAT9BvFSo5wQeJX1RxfgxPumsIi3qbQy7xQV6hXw5o6aILAPByawZfQ33aQoPW15AW9tJIfsSLt35d8zinOZjqjN8vMOGAGI3uQF-i6zmJ0VGnBSrRa-Sw",
            initParams: initParams) // call initSDK with initParams as a 2nd parameter.
        
    
        // MPNowPlayingInfoCenter
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        // Make status bar white
        UINavigationBar.appearance().barStyle = .black
        
        // FRadioPlayer config
        FRadioPlayer.shared.isAutoPlay = true
        FRadioPlayer.shared.enableArtwork = true
        FRadioPlayer.shared.artworkSize = 600
        
        // Get weak ref of StationsViewController
        if let navigationController = window?.rootViewController as? UINavigationController {
            stationsViewController = navigationController.viewControllers.first as? StationsViewController
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        UIApplication.shared.endReceivingRemoteControlEvents()
        
    }
    
    // MARK: - Remote Controls

    override func remoteControlReceived(with event: UIEvent?) {
        super.remoteControlReceived(with: event)
        
        guard let event = event, event.type == UIEventType.remoteControl else { return }
        
        switch event.subtype {
        case .remoteControlPlay:
            FRadioPlayer.shared.play()
        case .remoteControlPause:
            FRadioPlayer.shared.pause()
        case .remoteControlTogglePlayPause:
            FRadioPlayer.shared.togglePlaying()
        case .remoteControlNextTrack:
            stationsViewController?.didPressNextButton()
        case .remoteControlPreviousTrack:
            stationsViewController?.didPressPreviousButton()
        default:
            break
        }
    }
}

