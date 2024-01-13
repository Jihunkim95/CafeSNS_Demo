//
//  LoginPrepareView.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import SwiftUI
import GoogleSignInSwift
import Firebase
import FirebaseAuth


struct LoginPrepareView: View {
    @EnvironmentObject var vm: UserAuthModel
    
    var body: some View {
        
        GoogleSignInButton{
            Task {
                signInWithGoogle
                await vm.signIn()
            }
        }.frame(width: 300, height: 60, alignment: .center)
        

    }
    
}

