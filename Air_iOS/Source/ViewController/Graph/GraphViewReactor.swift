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
import SwiftMessages

final class GraphViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case refreshData
        case selectDay(Int)
    }
    
    enum Mutation {
        case updateData(StatsDataClass?, Int?)
        case setLoading(Bool)
    }
    
    struct State {
        var currentIndex = 6
        var dataClass: StatsDataClass?
        var stat: Stat?
        var totalTime: Int = 0
        var goal: Int = 0
        var percent: Double = 0
        var isLoading: Bool = false
        
        var legendSectionItems: [GraphLegendSectionItem] = []
        var legendSections: [GraphLegendSection] {
            let section: [GraphLegendSection] = [
                .legend(self.legendSectionItems)
            ]
            return section
        }
    }
    
    let userService: UserServiceType
    fileprivate let airAuthService: AirAuthServiceType
    
    init(airAuthService: AirAuthServiceType, userService: UserServiceType) {
        self.initialState = State()
        
        self.airAuthService = airAuthService
        self.userService = userService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refreshData:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.airAuthService.getStatList().asObservable()
                    .map { [weak self] result in
                        switch result {
                        case let .success(result):
                            return Mutation.updateData(result.data, self?.currentState.currentIndex)
                        case let .error(error):
                            print(error)
                            SwiftMessages.show(config: Message.airConfig, view: Message.faildView(error.message))
                            return Mutation.updateData(nil, self?.currentState.currentIndex)
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case let .selectDay(idx):
            return Observable.just(Mutation.updateData(currentState.dataClass, idx))
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = userService.event.flatMap { [weak self] event -> Observable<Mutation> in
            guard let self = self else { return Observable.empty() }
            
            switch event {
            case let .selectDays(index):
                return Observable.just(Mutation.updateData(self.currentState.dataClass, index))
            }
        }
        
        return Observable.merge(mutation, eventMutation)
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
            state.percent = stat.achievementRate
            
            // Legend
            state.legendSectionItems.removeAll()
            
            stat.subject.forEach {
                state.legendSectionItems.append(.legend(GraphViewLegendReactor(model: $0)))
            }
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
