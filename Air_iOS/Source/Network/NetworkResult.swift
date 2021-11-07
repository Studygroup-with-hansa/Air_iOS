//
//  NetworkResult.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/06.
//

import Foundation

enum NetworkResult {
    case success
    case error(NetworkError)
}
enum NetworkResultWithValue<T: Codable> {
  case success(T)
  case error(NetworkError)
}
