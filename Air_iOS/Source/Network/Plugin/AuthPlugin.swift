//
//  AuthPlugin.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import Moya

struct AuthPlugin: PluginType {
    fileprivate let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let token = self.authService.currentToken {
            request.addValue("Token " + token, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
