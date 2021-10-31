//
//  UserService.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/31.
//

import Foundation

import RxSwift

enum UserEvent {
    case selectDays(Int)
}

protocol UserServiceType {
    var event: PublishSubject<UserEvent> { get }
    func selectDays(index: Int) -> Observable<Int>
}

class UserSercice: UserServiceType {
    var event = PublishSubject<UserEvent>()
    
    func selectDays(index: Int) -> Observable<Int> {
        event.onNext(.selectDays(index))
        return Observable.just(index)
    }
}
