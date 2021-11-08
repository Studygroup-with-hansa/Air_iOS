//
//  ServerResponse.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import Foundation

struct ServerResponse<T: Codable>: ModelType {
    let status: Int
    let detail: String
    let data: T
}

// MARK: - TokenDataClass
struct TokenDataClass: Codable, Equatable {
    let token: String
}

// MARK: - EmailDataClass
struct EmailDataClass: Codable, Equatable {
    let isEmailExist, emailSent: Bool
}

// MARK: - StatsDataClass
struct StatsDataClass: Codable, Equatable {
    let totalTime, goals: Int
    let achievementRate: Double
    let stats: [Stat]
}

// MARK: - Stat
struct Stat: Codable, Equatable {
    let date: Date
    let totalStudyTime: Int
    let achievementRate: Double
    let subject: [Subject]
    let goal: Int
}

// MARK: - SubjectDataClass
struct SubjectDataClass: Codable, Equatable {
    let totalTime: Int
    let subject: [Subject]
    let goal: Int
}
// MARK: - Subject
struct Subject: Codable, Equatable {
    let title: String
    let time: Int
    let color: String
}
