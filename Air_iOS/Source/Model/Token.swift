//
//  Token.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import Foundation

// MARK: - Token
struct Token: ModelType {
    let status: Int
    let detail: String
    let data: TokenDataClass?
}

// MARK: - DataClass
struct TokenDataClass: Codable {
    let token: String
}
