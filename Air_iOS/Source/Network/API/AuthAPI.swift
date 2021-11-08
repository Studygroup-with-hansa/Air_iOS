//
//  AuthAPI.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import Moya

enum AuthAPI {
    case requestEmailCode(_ email: String)
    case sendEmailCode(_ email: String, _ code: String)
}

extension AuthAPI: BaseAPI {
    var path: String {
        switch self {
        case .requestEmailCode:
            return "/user/manage/signin/"
            
        case .sendEmailCode:
            return "/user/manage/signin/"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .requestEmailCode:
            return [
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
        case .sendEmailCode:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .requestEmailCode(email):
            return [
                "email" : email
            ]
        case let .sendEmailCode(email, code):
            return [
                "email" : email,
                "auth" : code
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestEmailCode:
            return .get
            
        case .sendEmailCode:
            return .put
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .sendEmailCode:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            }
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
        }
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .none
    }
}
