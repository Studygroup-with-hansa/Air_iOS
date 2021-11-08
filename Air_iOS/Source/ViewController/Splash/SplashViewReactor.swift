//
//  SplashViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/07.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class SplashViewReactor: Reactor, Stepper {
    
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case setNextView
    }
    
    typealias Mutation = NoMutation
    
    struct State {
        
    }
    
    fileprivate let authService: AuthServiceType
    init(authService: AuthServiceType) {
        self.initialState = State()
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setNextView:
            self.steps.accept(AirStep.loginIsRequired)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

