//
//  Network.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/15.
//

import RxSwift
import Moya

class Network<API: TargetType>: MoyaProvider<API> {
    
    init() {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        
        super.init(session: session)
    }
    
    func request(_ api: API) -> Single<Response> {
        return self.rx.request(api)
            .filter(statusCodes: 200...500)
    }
}

extension Network {
    func requestObject<T: ModelType>(_ target: API, type: T.Type) -> Single<NetworkResultWithValue<T>> {
        let decoder = type.decoder
        return request(target)
            .map(T.self, using: decoder)
            .map { result in
                guard let error = NetworkError(rawValue: result.code) else { return .success(result) }
                return .error(error)
            }.catchErrorJustReturn(.error(.unknown))
    }

}
