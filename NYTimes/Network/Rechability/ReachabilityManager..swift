//
//  Reachability.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()  // 2. Shared instance
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .unavailable
    
    // 5. Reachibility instance for Network status monitoring
    let reachability = try! Reachability()
    
    
    
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {

        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
//            self.showNoIntenetConnectionBanner()
        case .wifi:
            debugPrint("Network reachable through WiFi")
//            self.dismissNoIntenetConnectionBanner()
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
//            self.dismissNoIntenetConnectionBanner()
        case .unavailable:
            debugPrint("Network became unreachable")
        }
    }
    
    // we can handle this call for the app to notify user about internet unavailability
    func showNoIntenetConnectionBanner() {
//        DispatchQueue.main.async {
//            if let keyWindow = UIApplication.shared.keyWindow {
//                if let rootViewController = keyWindow.rootViewController {
//                    rootViewController.topMostViewController().showNoInternetAvailable()
//                }
//            }
//        }
    }
    
    func dismissNoIntenetConnectionBanner() {
//        DispatchQueue.main.async {
//            if let keyWindow = UIApplication.shared.keyWindow {
//                if let rootViewController = keyWindow.rootViewController {
//                    rootViewController.topMostViewController().dismissNoInternetAvailable()
//                }
//            }
//        }
    }
    
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
}
