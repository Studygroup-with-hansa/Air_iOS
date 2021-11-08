//
//  Date.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/18.
//

import Foundation

public extension Date {
    
    var dateString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy.MM.dd"
            $0.locale = Locale.init(identifier: "ko-KR")
        }
        return formatter.string(from: self)
    }
    
    var toWeekDay: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "EEEEE"
            $0.locale = Locale.init(identifier: "ko-KR")
        }
        return formatter.string(from: self)
    }
    
    var toDay: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "dd"
        }
        return formatter.string(from: self)
    }
    
    var dataString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return formatter.string(from: self)
    }
    
    var weekAgo: Date {
        return Date(timeIntervalSinceNow: -86400 * 6)
    }
}
