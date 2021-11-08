//
//  LoginViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class LoginViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    fileprivate let authService: AuthServiceType
    init(authService: AuthServiceType) {
        self.initialState = State()
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
