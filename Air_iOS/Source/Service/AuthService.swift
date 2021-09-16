//
//  AuthService.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import RxSwift

protocol AuthServiceType {
    func requestCode(_ email: String) -> Single<Void>
    func sendCode(_ email: String, _ code: String) -> Single<Void>
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    
    init(network: Network<AuthAPI>) {
        self.network = network
    }
    
    func requestCode(_ email: String) -> Single<Void> {
        return network.requestObject(.requestEmailCode(email), type: Email.self).map { _ in }
    }
    
    func sendCode(_ email: String, _ code: String) -> Single<Void> {
        return network.requestObject(.sendEmailCode(email, code), type: Token.self).map{ _ in }
    }
    
}
