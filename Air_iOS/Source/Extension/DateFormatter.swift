//
//  DateFormatter.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/15.
//

import Foundation
import Then

extension DateFormatter {
    
    static let serverDate = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
        $0.calendar = Calendar(identifier: .iso8601)
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.locale = Locale(identifier: "ko_kr")
    }
 
}
