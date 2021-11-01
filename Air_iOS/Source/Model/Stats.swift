//
//  Stats.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/06.
//

import Foundation

// MARK: - Stats
struct Stats: ModelType, Equatable {
    let status: Int
    let detail: String
    let data: StatsDataClass
}

// MARK: - DataClass
struct StatsDataClass: ModelType, Equatable {
    let totalTime, goals: Int
    let achievementRate: Double
    let stats: [Stat]
}

// MARK: - Stat
struct Stat: ModelType, Equatable {
    let date: Date
    let totalStudyTime: Int
    let achievementRate: Double
    let subject: [Subject]
    let goal: Int
}
