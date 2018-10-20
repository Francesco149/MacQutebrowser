// wrapper app bundle for qutebrowser
//
// macOS clusterfucks everything you have to do this just to get
// it recognized as a browser/url handler

import Cocoa
import Foundation

// TODO: find out a way to rename the window (opens as 'Python3.7')
let qutebrowser = "/usr/local/opt/qutebrowser/bin/qutebrowser"

func shell(_ args: String...) {
  let task = Process()
  task.launchPath = "/usr/bin/env"
  task.arguments = args
  task.launch()
}

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationWillFinishLaunching(_ notif: Notification) {
    NSAppleEventManager.shared().setEventHandler(self,
      andSelector: #selector(onURL(_:replyEvent:)),
      forEventClass: AEEventClass(kInternetEventClass),
      andEventID: AEEventID(kAEGetURL))
  }

  func applicationDidFinishLaunching(_ notif: Notification) {
    shell(qutebrowser)
    NSApplication.shared.terminate(self)
  }

  @objc
  func onURL(_ event: NSAppleEventDescriptor,
    replyEvent: NSAppleEventDescriptor)
  {
    let kword = AEKeyword(keyDirectObject)
    let descriptor = event.paramDescriptor(forKeyword: kword)
    guard
      let urlString = descriptor?.stringValue,
      let url = URL(string: urlString)
    else {
      NSLog("no valid url to handle")
      return
    }
    NSLog("handling \(urlString)")
    switch url.scheme {
      case "http", "https", "file":
        shell(qutebrowser, "--", ":open -t \(urlString)")
      default:
        break
    }
    NSApplication.shared.terminate(self)
  }

  func applicationWillTerminate(_ notif: Notification) {
    NSLog("bye")
  }
}

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
