//
//  Email.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import Foundation

// MARK: - Email
struct Email: Codable {
    let status: Int
    let detail: String
    let data: EmailDataClass
}

// MARK: - DataClass
struct EmailDataClass: Codable {
    let isEmailExist, emailSent: Bool
}
