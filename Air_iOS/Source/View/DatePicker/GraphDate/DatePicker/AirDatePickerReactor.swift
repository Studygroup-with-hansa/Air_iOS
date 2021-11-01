//
//  AirDatePickerReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/26.
//

import Foundation

import ReactorKit
import RxRelay

final class AirDatePickerReactor: Reactor {
    
    let initialState: State
    
    typealias Action = NoAction
    
    enum Mutation {
        
    }
    
    struct State {
        var stats: [Stat]
    }
    
    let userService: UserServiceType
    
    init(models: [Stat], userService: UserServiceType) {
        self.initialState = State(stats: models)
        self.userService = userService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}

