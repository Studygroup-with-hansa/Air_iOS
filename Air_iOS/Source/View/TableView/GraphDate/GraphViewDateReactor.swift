//
//  GraphViewDateReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import Foundation

import ReactorKit
import RxRelay

final class GraphViewDateReactor: Reactor {
    
    let initialState: State
    
    typealias Action = NoAction
    
    enum Mutation {
        
    }
    
    struct State {
        var date: Date
        var total: Int
        var goal: Int
    }
    
    init(model: Stat) {
        self.initialState = State(date: model.date, total: model.totalStudyTime, goal: model.goal )
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
