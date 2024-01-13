//
//  ContentView.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignInSwift
import GoogleSignIn



struct ContentView: View {
    
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

    var body: some View {
        VStack{
            if userLoggedIn {
                MainView()
            } else {
                LoginPrepareView()
            }
        }.onAppear{
            //로그인여부
            Auth.auth().addStateDidChangeListener{ auth, user in
                if (user != nil) {
                    userLoggedIn = true
                } else {
                    userLoggedIn = false
                }
            }
        }
 
    }
}

#Preview {
    ContentView()
}
