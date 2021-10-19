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
        case selectDay(Int)
    }
    
    enum Mutation {
        case updateData(StatsDataClass?, Int?)
    }
    
    struct State {
        var currentIndex = 0
        var dataClass: StatsDataClass?
        var stat: Stat?
        var totalTime: Int = 0
        var goal: Int = 0
        var percent: String = ""
        
        var legendSectionItems: [GraphLegendSectionItem] = []
        var dateSectionItems: [GraphDateSectionItem] = []
        var legendSections: [GraphLegendSection] {
            let section: [GraphLegendSection] = [
                .legend(self.legendSectionItems)
            ]
            return section
        }
        var dateSections: [GraphDateSection] {
            let section: [GraphDateSection] = [
                .date(self.dateSectionItems)
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
            let stats = try? Stats.decoder.decode(Stats.self, from: jsonString.data(using: .utf8)!)
            return Observable.just(Mutation.updateData(stats?.data, currentState.currentIndex))
            
        case let .selectDay(idx):
            return Observable.just(Mutation.updateData(currentState.dataClass, idx))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
            
        case let .updateData(dataClass, idx):
            guard let dataClass = dataClass else { return state }
            guard let idx = idx else { return state }
            
            // Graph
            let stat = dataClass.stats[idx]
            state.currentIndex = idx
            state.dataClass = dataClass
            state.stat = stat
            state.totalTime = stat.totalStudyTime
            state.goal = stat.goal
            state.percent = (Double(state.goal) / Double(state.totalTime)).toPercentage
            
            // Legend
            state.legendSectionItems.removeAll()
            stat.subject.forEach {
                state.legendSectionItems.append(.legend(GraphViewLegendReactor(model: $0)))
            }
            
            state.dateSectionItems.removeAll()
            dataClass.stats.forEach {
                state.dateSectionItems.append(.date(GraphViewDateReactor(model: $0)))
            }
            
        }
        
        return state
    }
}
