//
//  User.swift
//  CafeSNS_Demo
//
//  Created by 김지훈 on 2024/01/13.
//

import Foundation

struct User {
    var id: Int
    var name: String?
    var email: String
    var passwordHash: String? // 자체 로그인의 경우 사용되는 비밀번호 해시
    var socialID: String? // 소셜 로그인의 경우 사용되는 소셜 계정 ID
    var logintype: String
    var socialProvider: SocialProvider? // 소셜 로그인 제공자

    var nickName: String
}

enum SocialProvider {
    case google
    case apple
}
