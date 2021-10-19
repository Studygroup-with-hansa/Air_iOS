//
//  Date.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/18.
//

import Foundation

public extension Date {
    
    var toWeekDay: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "EEEEE"
        }
        return formatter.string(from: self)
    }
    
    var toDay: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "dd"
        }
        return formatter.string(from: self)
    }
}
