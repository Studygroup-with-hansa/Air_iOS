//
//  Subject.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/01.
//

import Foundation

// MARK: - Subjects
struct Subjects: Codable {
    let status: Int
    let detail: String
    let data: SubjectDataClass
}

// MARK: - DataClass
struct SubjectDataClass: Codable {
    let totalTime: Int
    let subject: [Subject]
    let goal: Int
}
// MARK: - Subject
struct Subject: ModelType, Equatable {
    let title: String
    let time: Int
    let color: String
}
