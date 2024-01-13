//
//  User.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import Foundation

struct User {
//    let id: Int //DB에서 채번되야함
    let url:URL?
    let name:String
    let email:String
    var passwordHash: String? // 자체 로그인의 경우 사용되는 비밀번호 해시
    var socialID: String? // 소셜 로그인의 경우 사용되는 소셜 계정 ID
    var socialProvider: SocialProvider? // 소셜 로그인 제공자
    var nickName: String

    init(url: URL?, name: String, email: String, passwordHash: String? = nil, socialID: String? = nil, socialProvider: SocialProvider? = nil, nickName: String) {
        self.url = url
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.socialID = socialID
        self.socialProvider = socialProvider
        self.nickName = nickName
    }

}



enum SocialProvider {
    case google
    case apple
}

