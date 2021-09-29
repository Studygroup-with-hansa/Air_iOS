//
//  String.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import Foundation

extension String {
    var toTwoDigits: String {
        String(self).count == 1 ? "0" + String(self) : String(self)
    }
}
