//
//  ModelType.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import Foundation
import Then

protocol ModelType: Codable, Then {
    
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
    
    static var decoder: JSONDecoder { get }
    
    var status: Int { get }
    
    var detail: String { get }
}

extension ModelType {
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return .formatted(formatter)
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = self.dateDecodingStrategy
        return decoder
    }
}
