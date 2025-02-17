//
//  AppDelegate.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import AppKit

// Main.storyboard 기본 윈도우 띄우지 않으려면
// Main.Storyboard -> Window Controller Scene
// -> Window Controller -> Is Initial Controller, uncheck 한다.
//
// project 파일 수정하지 않고 이렇게 하는 것이 무난해 보인다.

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        saveWindowPosition()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func setupWindow() {
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.title = "Simple Todo"
        window.contentViewController = HomeController()
        window.layoutIfNeeded()
        restoreWindowPosition()
        window.makeKeyAndOrderFront(nil)
    }

    private func saveWindowPosition() {
        let frameString = NSStringFromRect(window.frame)
        UserDefaults.standard.set(frameString, forKey: "MainWindowFrame")
    }

    private func restoreWindowPosition() {
        if let frameString = UserDefaults.standard.string(forKey: "MainWindowFrame") {
            let frame = NSRectFromString(frameString)
            window.setFrame(frame, display: true)
        } else {
            window.center()
        }
    }

}

