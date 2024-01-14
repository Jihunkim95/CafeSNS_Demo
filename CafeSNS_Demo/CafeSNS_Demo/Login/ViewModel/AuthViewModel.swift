//
//  UserViewModel.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import Foundation
import GoogleSignIn
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var userData: User
    @Published var isLogined:Bool = false
    @Published var isAlert = false


    init() {
        self.userData = User(url: nil, name: "", email: "", nickName: "")
    }
    
    func checkState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }

            if error != nil || user == nil {
                print("Not Sign In")
            } else {
                guard let profile = user?.profile else { return }
                let data = User(url: profile.imageURL(withDimension: 180),
                                name: profile.name,
                                email: profile.email,
                                socialProvider: SocialProvider.google,
                                nickName: profile.givenName ?? "")
                self.userData = data
                self.isLogined = true
            }
        }
    }

    func googleLogin() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] signInResult, error in
            guard let self = self else { return }

            if let error = error {
                print(error.localizedDescription)
                self.isAlert = true
                return
            }

            guard let result = signInResult, let profile = result.user.profile else {
                self.isAlert = true
                return
            }
            
            let data = User(url: profile.imageURL(withDimension: 180),
                            name: profile.name,
                            email: profile.email,
                            socialProvider: SocialProvider.google,
                            nickName: profile.givenName ?? "")
            self.userData = data
            self.isLogined = true
        }

        // 성공적으로 로그인한 후 Firestore에 사용자 데이터 저장
        saveUserToFirestore()
    }
    
    //FirebaseDB에 저장
    func saveUserToFirestore() {
        print("Test")
        // Firestore 데이터베이스 인스턴스 생성
        let db = Firestore.firestore()

        // 저장할 사용자 데이터
        let userData = [
            "url": self.userData.url?.absoluteString ?? "",
            "name": self.userData.name,
            "email": self.userData.email,
            "socialProvider": self.userData.socialProvider?.rawValue ?? "",
            "nickName": self.userData.nickName,
            "lastDateTime": Date()
        ] as [String : Any]

        // Firestore에 사용자 데이터 저장
        db.collection("users").document(self.userData.email).setData(userData) { error in
            if let error = error {
                print("Error writing document: \(error)")
                self.isAlert = true
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
