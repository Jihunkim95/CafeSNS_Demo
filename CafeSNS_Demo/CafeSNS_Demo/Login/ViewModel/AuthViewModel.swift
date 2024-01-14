//
//  UserViewModel.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import Foundation
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class AuthViewModel: ObservableObject {
    
    @Published var userData: User
    @Published var isLogined:Bool = false
    @Published var isAlert:Bool = false


    init() {
        self.userData = User(uid: "" ,url: nil, name: "", email: "")
    }
    
    func checkState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }

            if error != nil || user == nil {
                
                self.isAlert = true
                print("로그인 실패")
                
            } else {
                guard let profile = user?.profile else { return }
                let data = User(uid: self.userData.uid,
                                url: profile.imageURL(withDimension: 180),
                                name: profile.name,
                                email: profile.email,
                                socialProvider: SocialProvider.google)
                self.userData = data
                self.isLogined = true
            }
        }
    }

    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // 버튼 클릭시 내부로 들어가는 컨트롤
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                
                if let error = error{
                    //오류처리
                    print("Google Sign-In error: \(error)")
                    return
                }
                
                guard let user = result?.user,
                      let idToken = result?.user.idToken?.tokenString
                else {
                    print("user정보와 idToken을 찾지못함")
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    
                    if let error = error {
                        // Firebase 인증 중 오류 발생
                        print("Firebase Sign-In error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let authResult = authResult {
                        // Firebase 인증 성공
                        print("Firebase Sign-In successful: \(authResult.user.uid)")
                        // 추가적인 사용자 처리 로직을 구현할 수 있습니다.
                        let data = User(uid: authResult.user.uid,
                                        url: authResult.user.photoURL,
                                        name: authResult.user.displayName ?? "",
                                        email: authResult.user.email ?? "",
                                        socialProvider: SocialProvider.google
                                        )
                        
                        self.userData = data
                        self.isLogined = true
                        self.saveUserToFirestore()
                        
                    } else {
                        // Firebase 인증 결과가 없는 경우
                        print("Firebase Sign-In result not found")
                    }
                }

            }
        }

    }
    
    //FirebaseDB에 저장
    func saveUserToFirestore() {
        // Firestore 데이터베이스 인스턴스 생성
        let db = Firestore.firestore()

        // 저장할 사용자 데이터
        let userData = [
            "uid": self.userData.uid,
            "url": self.userData.url?.absoluteString ?? "",
            "name": self.userData.name,
            "email": self.userData.email,
            "socialProvider": self.userData.socialProvider?.rawValue ?? "",
            "lastDateTime": Date()
        ] as [String : Any]

        // Firestore에 사용자 데이터 저장
        db.collection("users").document(self.userData.uid).setData(userData) { error in
            if let error = error {
                print("Error writing document: \(error)")
                self.isAlert = true
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
