//
//  MainViewCellReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/02.
//

import Foundation

import ReactorKit
import RxRelay

final class MainViewCellReactor: Reactor {
    
    let initialState: State
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var title: String
        var time: Int
        var percent: Double
        var color: String
    }
    
    init(model: Subject, percent: Double) {
        self.initialState = State(title: model.title, time: model.time, percent: percent, color: model.color)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
