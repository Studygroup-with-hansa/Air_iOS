//
//  AuthService.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/16.
//

import RxSwift
import KeychainAccess

protocol AuthServiceType: AnyObject {
    var currentToken: String? { get }
    
    func requestCode(_ email: String) -> Single<NetworkResultWithValue<ServerResponse<EmailDataClass>>>
    func sendCode(_ email: String, _ code: String) -> Single<NetworkResult>
}

final class AuthService: AuthServiceType {
    
    fileprivate let network: Network<AuthAPI>
    fileprivate let keychain = Keychain(service: "com.hansarang.ios.air.Air-iOS")
    private(set) var currentToken: String?
    
    init(network: Network<AuthAPI>) {
        self.network = network
        self.currentToken = self.getToken()
    }
    
    func requestCode(_ email: String) -> Single<NetworkResultWithValue<ServerResponse<EmailDataClass>>> {
        return network.requestObject(.requestEmailCode(email), type: ServerResponse<EmailDataClass>.self)
            .map { result in
                switch result {
                case let .success(result):
                    return .success(result)
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func sendCode(_ email: String, _ code: String) -> Single<NetworkResult> {
        return network.requestObject(.sendEmailCode(email, code), type: ServerResponse<TokenDataClass>.self)
            .map { [weak self] result in
                switch result {
                case let .success(result):
                    try? self?.saveToken(result.data.token)
                    self?.currentToken = result.data.token
                    return .success
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func logout() {
        self.currentToken = nil
        self.removeToken()
    }
    
    fileprivate func saveToken(_ token: String) throws {
        try self.keychain.set(token, key: "token")
    }
    
    fileprivate func getToken() -> String? {
        guard let token = try? keychain.getString("token") else { return nil }
        
        return token
    }
    
    fileprivate func removeToken() {
        try? self.keychain.remove("token")
    }
    
}
