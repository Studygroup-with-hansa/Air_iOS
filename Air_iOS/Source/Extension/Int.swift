//
//  Int.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import Foundation

extension Int {
    var toTimeString: String {
        let seconds = self % 60
        let minutes = self / 60
        let hour = self / 3600
        
        return "\(hour)H \(minutes - 60 * hour)M \(seconds)S"
    }
}
