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
