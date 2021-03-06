//
//  DeviceType.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

import Foundation

enum DeviceType {
    case iPodTouch
    case iPhoneSE2
    case iPhone13Pro
    case iPhone13ProMax
    case iPhone13mini

    func name() -> String {
        switch self {
        case .iPodTouch:
            return "iPod touch (7th generation)"
        case .iPhoneSE2:
            return "iPhone SE (2nd generation)"
        case .iPhone13Pro:
            return "iPhone 13 Pro"
        case .iPhone13ProMax:
            return "iPhone 13 Pro Max"
        case .iPhone13mini:
            return "iPhone 13 mini"
        }
    }
}
