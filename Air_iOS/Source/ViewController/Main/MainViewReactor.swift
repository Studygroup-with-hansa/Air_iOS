//
//  MainViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/01.
//

import Foundation

import ReactorKit
import SwiftMessages
import RxFlow
import RxRelay

final class MainViewReactor: Reactor, Stepper {
    
    var steps = PublishRelay<Step>()
    
    
    let initialState: State
    
    enum Action {
        case refreshData
    }
    
    enum Mutation {
        case updateData(SubjectDataClass?)
        case setLoading(Bool)
    }
    
    struct State {
        var totalTime: Int = 0
        var goal: Int = 0
        var subject: [Subject] = []
        var isLoading: Bool = false
        
        var sectionItems: [MainSectionItem] = []
        var sections: [MainSection] {
            let section: [MainSection] = [
                .mainCell(self.sectionItems)
            ]
            return section
        }
    }
    
    let airAuthService: AirAuthServiceType
    
    init(airAuthService: AirAuthServiceType) {
        self.initialState = State()
        
        self.airAuthService = airAuthService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refreshData:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.airAuthService.getSubjectList().asObservable()
                    .map { result in
                        switch result {
                        case let .success(result):
                            return Mutation.updateData(result.data)
                        case let .error(error):
                            print(error)
                            SwiftMessages.show(config: Message.airConfig, view: Message.faildView(error.message))
                            return Mutation.updateData(nil)
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateData(dataClass):
            guard let dataClass = dataClass else { return state }
            
            state.totalTime = dataClass.totalTime
            state.goal = dataClass.goal
            state.subject = dataClass.subject
            
            state.sectionItems.removeAll()
            
            dataClass.subject.forEach {
                let percent: Double = Double($0.time) / Double(dataClass.totalTime) * 100
                state.sectionItems.append(.mainCell(MainViewCellReactor(model: $0, percent: percent, steps: self.steps)))
            }
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}

