//
//  CafeSNS_DemoApp.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/12.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn


@main
struct CafeSNS_DemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginView(authVM: AuthViewModel())
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
