//
//  GraphViewLegendReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/14.
//

import Foundation

import ReactorKit
import RxRelay

final class GraphViewLegendReactor: Reactor {
    
    let initialState: State
    
    typealias Action = NoAction
    
    enum Mutation {
        
    }
    
    struct State {
        var color: UIColor
        var title: String
    }
    
    init(model: Subject) {
        self.initialState = State(color: model.color.hexString, title: model.title + " : " + model.time.toTimeString)
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}


