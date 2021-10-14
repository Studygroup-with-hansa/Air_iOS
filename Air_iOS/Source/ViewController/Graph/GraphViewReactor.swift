//
//  GraphViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class GraphViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    
    
    let initialState: State
    
    enum Action {
        case refreshData
    }
    
    enum Mutation {
        case updateData(StatsDataClass?)
    }
    
    struct State {
        var currentIndex = 0
        var stat: Stat?
        var totalTime: Int = 0
        var goal: Int = 0
        var percent: String = ""
//        var today: Date
        
        var legendSectionItems: [GraphLegendSectionItem] = []
        var sections: [GraphLegendSection] {
            let section: [GraphLegendSection] = [
                .legend(self.legendSectionItems)
            ]
            return section
        }
    }
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refreshData:
            guard let path = Bundle.main.path(forResource: "StatsMock", ofType: "json") else { return Observable.empty() }
            guard let jsonString = try? String(contentsOfFile: path) else { return Observable.empty() }
            print(jsonString)
            let stats = try? JSONDecoder().decode(Stats.self, from: jsonString.data(using: .utf8)!)
            return Observable.just(Mutation.updateData(stats?.data))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
            
        case let .updateData(dataClass):
            guard let dataClass = dataClass else { return state }
            
            // Graph
            let stat = dataClass.stats[currentState.currentIndex]
            state.stat = stat
            state.totalTime = stat.totalStudyTime
            state.goal = stat.goal
            state.percent = (Double(state.goal) / Double(state.totalTime)).toPercentage
            
            // Legend
            state.legendSectionItems.removeAll()
            stat.subject.forEach {
                state.legendSectionItems.append(.legend(GraphViewLegendReactor(model: $0)))
            }
        }
        
        return state
    }
}
