//
//  AppDelegate.swift
//  CastSender
//
//  Created by Masato Arai on 23/09/2024.
//

import UIKit
import GoogleCast

class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate var enableSDKLogging = true

    let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
    let kDebugLoggingEnabled = true

    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let criteria = GCKDiscoveryCriteria(applicationID: kReceiverAppID)
        let options = GCKCastOptions(discoveryCriteria: criteria)
        options.physicalVolumeButtonsWillControlDeviceVolume = true
        GCKCastContext.setSharedInstanceWith(options)

        window?.clipsToBounds = true
        setupCastLogging()
        
//        // Enable logger.
//        GCKLogger.sharedInstance().delegate = self
//        print("Hello")
        return true
    }

    func setupCastLogging() {
        let logFilter = GCKLoggerFilter()
        let classesToLog = [
            "GCKDeviceScanner",
            "GCKDeviceProvider",
            "GCKDiscoveryManager",
            "GCKCastChannel",
            "GCKMediaControlChannel",
            "GCKUICastButton",
            "GCKUIMediaController",
            "NSMutableDictionary"
        ]
        logFilter.setLoggingLevel(.verbose, forClasses: classesToLog)
        GCKLogger.sharedInstance().filter = logFilter
        GCKLogger.sharedInstance().delegate = self
    }
}

// MARK: - GCKLoggerDelegate

extension AppDelegate: GCKLoggerDelegate {
    func logMessage(
        _ message: String,
        at _: GCKLoggerLevel,
        fromFunction function: String,
        location: String
    ) {
        if enableSDKLogging {
            // Send SDK's log messages directly to the console.
            print("\(location): \(function) - \(message)")
        }
    }
}
