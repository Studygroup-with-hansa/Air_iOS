//
//  TimerViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/28.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class TimerViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case increaseTime(Int)
    }
    
    enum Mutation {
        case updateTime(Int)
    }
    
    struct State {
        var time: Int
    }
    
    init() {
        self.initialState = State(time: 0)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .increaseTime(seconds):
            return Observable.just(Mutation.updateTime(seconds))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateTime(seconds):
            state.time = seconds
        }
        
        return state
    }
}
