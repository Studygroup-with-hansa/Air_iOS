//
//  AirAuthService.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import RxSwift

protocol AirAuthServiceType: AnyObject {
    func getSubjectList() -> Single<NetworkResultWithValue<ServerResponse<SubjectDataClass>>>
    func getStatList() -> Single<NetworkResultWithValue<ServerResponse<StatsDataClass>>>
}

final class AirAuthService: AirAuthServiceType {
    
    fileprivate let network: Network<MainAPI>
    
    init(network: Network<MainAPI>) {
        self.network = network
    }
    
    func getSubjectList() -> Single<NetworkResultWithValue<ServerResponse<SubjectDataClass>>> {
        return network.requestObject(.getSubjectList, type: ServerResponse<SubjectDataClass>.self)
            .map { result in
                switch result {
                case let .success(result):
                    return .success(result)
                case let .error(error):
                    return .error(error)
                }
            }
    }
    
    func getStatList() -> Single<NetworkResultWithValue<ServerResponse<StatsDataClass>>> {
        return network.requestObject(.getStats, type: ServerResponse<StatsDataClass>.self)
            .map { result in
                switch result {
                case let .success(result):
                    return .success(result)
                case let .error(error):
                    return .error(error)
                }
            }
    }
}
