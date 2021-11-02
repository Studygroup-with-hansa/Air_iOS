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
        case refreshData
    }
    
    enum Mutation {
        case updateData(SubjectDataClass?)
    }
    
    struct State {
        var totalTime: Int = 0
        var goal: Int = 0
        var subject: [Subject] = []
        
        var sectionItems: [MainSectionItem] = []
        var sections: [MainSection] {
            let section: [MainSection] = [
                .mainCell(self.sectionItems)
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
            guard let path = Bundle.main.path(forResource: "MainMock", ofType: "json") else { return Observable.empty() }
            guard let jsonString = try? String(contentsOfFile: path) else { return Observable.empty() }
            let subjects = try? Stats.decoder.decode(Subjects.self, from: jsonString.data(using: .utf8)!)
            return Observable.just(Mutation.updateData(subjects?.data))
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
                let percent: Double = Double($0.time % dataClass.totalTime)
                state.sectionItems.append(.mainCell(MainViewCellReactor(model: $0, percent: percent)))
            }

        }
        
        return state
    }
}

