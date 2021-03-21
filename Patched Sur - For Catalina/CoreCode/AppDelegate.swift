//
//  AppDelegate.swift
//  Patched Sur - For Catalina
//
//  Created by Benjamin Sova on 9/23/20.
//

import Cocoa
import VeliaUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 584, height: 346),
            styleMask: [.titled, .miniaturizable, .fullSizeContentView, .borderless],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = true
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
//        let queue = DispatchQueue(label: "DownloadKexts")
//        queue.
        // https://stackoverflow.com/a/34574966
//        queue.suspend()
        _ = try? call("killall curl")
        _ = try? call("killall createinstallmedia")
    }

}

class AppInfo {
    static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let build = Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)!
    static let micropatcher = { () -> String in
        guard let micropatchers = try? MicropatcherRequirements(fromURL: "https://bensova.github.io/patched-sur/micropatcher.json") else {
            return "0.5.0"
        }
        let micropatcher = micropatchers.filter { $0.patcher <= Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)! }.last!
        return micropatcher.version
    }()
}

extension AnyTransition {

    static var moveAway: AnyTransition {
        return .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))

    }

}
