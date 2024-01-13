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


struct LoginView: View {
    
    // 유저 데이터
    @StateObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GoogleSignInButton(
                    scheme: .light,
                    style: .wide,
                    action: {
                        authVM.googleLogin()
                    })
                .frame(width: 300, height: 60, alignment: .center)
            }
            .navigationDestination(isPresented: $authVM.isLogined, destination: {
                MainView(userData: $authVM.userData)
            })
        }
        .onAppear(perform: {
            // 로그인 상태 체크
            authVM.checkState()
        })
        .alert(LocalizedStringKey("로그인 실패"), isPresented: $authVM.isAlert) {
            Text("확인")
        } message: {
            Text("다시 시도해주세요")
        }
    }
}

