//
//  AppDelegate.swift
//  CastSender
//
//  Created by Masato Arai on 23/09/2024.
//

import UIKit
import GoogleCast

class AppDelegate: UIResponder, UIApplicationDelegate, GCKLoggerDelegate {
    let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
    let kDebugLoggingEnabled = true

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("Your code here")

        let criteria = GCKDiscoveryCriteria(applicationID: kReceiverAppID)
        let options = GCKCastOptions(discoveryCriteria: criteria)
        GCKCastContext.setSharedInstanceWith(options)

        // Enable logger.
        GCKLogger.sharedInstance().delegate = self
    }

    // MARK: - GCKLoggerDelegate

    func logMessage(_ message: String,
                    at level: GCKLoggerLevel,
                    fromFunction function: String,
                    location: String) {
        if (kDebugLoggingEnabled) {
            print(function + " - " + message)
        }
    }

//    func application(_: UIApplication,
//                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        let options = GCKCastOptions(discoveryCriteria: GCKDiscoveryCriteria(applicationID: kReceiverAppID))
//        options.physicalVolumeButtonsWillControlDeviceVolume = true
//        GCKCastContext.setSharedInstanceWith(options)
//
//        window?.clipsToBounds = true
//        setupCastLogging()
//
//        print("Your code here")
//        return
//    }
}
