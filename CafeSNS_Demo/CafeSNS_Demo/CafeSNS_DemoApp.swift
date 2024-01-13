//
//  CafeSNS_DemoApp.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/12.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CafeSNS_DemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
