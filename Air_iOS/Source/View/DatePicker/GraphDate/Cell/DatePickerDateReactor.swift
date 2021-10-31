//
//  DatePickerDateReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import Foundation

import ReactorKit
import RxRelay

final class DatePickerDateReactor: Reactor {
    
    let initialState: State
    
    enum Action {
        case changeIndex(Int)
    }
    
    typealias Mutation = NoMutation
    
    struct State {
        var date: Date
        var achievementRate: Double
        var index: Int
    }
    
    let userService: UserServiceType
    
    init(model: Stat, index: Int, userService: UserServiceType) {
        self.initialState = State(date: model.date, achievementRate: model.achievementRate, index: index)
        
        self.userService = userService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeIndex(index):
            return Observable.just(userService.selectDays(index: index))
                .flatMap { _ in Observable.empty() }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
