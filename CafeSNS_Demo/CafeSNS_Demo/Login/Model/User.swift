//
//  User.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import Foundation

struct User {
    let uid: String //DB에서 채번되야함
    let url:URL?
    let name:String
    let email:String
    var passwordHash: String? // 자체 로그인의 경우 사용되는 비밀번호 해시
    var socialProvider: SocialProvider? // 소셜 로그인 제공자
    

    init(uid: String, url: URL?, name: String, email: String, passwordHash: String? = nil, socialProvider: SocialProvider? = nil) {
        self.uid = uid
        self.url = url
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.socialProvider = socialProvider
    }

}



enum SocialProvider: String {
    case google = "Google"
    case apple = "Apple"
}

