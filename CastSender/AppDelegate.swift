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

        // Customise UI
        let castStyle = GCKUIStyle.sharedInstance()
        let backgroundColor: UIColor = UIColor.black
        let foregroundColor: UIColor = UIColor.white

        castStyle.castViews.backgroundColor = backgroundColor
        castStyle.castViews.iconTintColor = foregroundColor
        castStyle.castViews.bodyTextColor = foregroundColor
        castStyle.castViews.headingTextColor = foregroundColor
        castStyle.castViews.buttonTextColor = UIColor.green

        // Navigation
        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.navigation.backgroundColor = backgroundColor

        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.navigation.headingTextColor = foregroundColor
//        GCKUIStyle.sharedInstance().castViews.headingTextFont = UIFont(.universBold, size: 18)

        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.navigation.buttonTextColor = foregroundColor

        // Content - Device selection
        castStyle.castViews.deviceControl.deviceChooser.backgroundColor = backgroundColor
        castStyle.castViews.deviceControl.deviceChooser.headingTextColor = foregroundColor
        castStyle.castViews.deviceControl.deviceChooser.iconTintColor = foregroundColor

        // Connection Controller
        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.iconTintColor = UIColor.green
//        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.playImage = UIImage(named: "quote")!
        GCKUIStyle.sharedInstance().castViews.deviceControl.connectionController.captionTextColor = UIColor.green

        castStyle.apply()


        window?.clipsToBounds = true
        setupCastLogging()
        
        // Enable logger.
        GCKLogger.sharedInstance().delegate = self

        // Expanded controller
        GCKCastContext.sharedInstance().useDefaultExpandedMediaControls = true

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
