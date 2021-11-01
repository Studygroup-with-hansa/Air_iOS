//
//  MainViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/01.
//

import Foundation

import ReactorKit
import RxRelay

final class MainViewReactor: Reactor {
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

