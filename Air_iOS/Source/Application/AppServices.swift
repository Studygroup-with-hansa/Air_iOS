//
//  AppServices.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/15.
//

import Foundation
import SnapKit
import CGFloatLiteral
import Rswift

struct AppServices {
    
    let authService: AuthServiceType
    let userService: UserServiceType
    let airAuthService: AirAuthServiceType
    
    init() {
        self.userService = UserSercice()
        
        let authNetwork = Network<AuthAPI>(plugins: [
            RequestLoggingPlugin()
        ])
        self.authService = AuthService(network: authNetwork)
        
        let airAuthNetwork = Network<MainAPI>(plugins: [
            RequestLoggingPlugin(),
            AuthPlugin(authService: self.authService)
        ])
        self.airAuthService = AirAuthService(network: airAuthNetwork)
    }
    
}
