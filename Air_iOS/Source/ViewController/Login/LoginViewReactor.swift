//
//  LoginViewReactor.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow
import SwiftMessages

final class LoginViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case updateTextField([String])
        case requestCode
        case sendCode
    }
    
    enum Mutation {
        case setLoading(Bool)
        case updateData([String])
        case updateExist(Bool)
    }
    
    struct State {
        var email: String = ""
        var code: String = ""
        var isLoading: Bool = false
        var isEmailExist: Bool = false
    }
    
    fileprivate let authService: AuthServiceType
    init(authService: AuthServiceType) {
        self.initialState = State()
        
        self.authService = authService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateTextField(data):
            return Observable.just(Mutation.updateData(data))
            
        case .requestCode:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.requestCode(self.currentState.email).asObservable()
                    .map { result in
                        switch result {
                        case let .success(result):
                            SwiftMessages.show(config: Message.airConfig, view: Message.successView("코드가 성공적으로 전송되었습니다."))
                            return Mutation.updateExist(result.data.isEmailExist)
                        case let .error(error):
                            SwiftMessages.show(config: Message.airConfig, view: Message.faildView(error.message))
                            return Mutation.updateExist(false)
                        }
                    },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .sendCode:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                self.authService.sendCode(self.currentState.email, self.currentState.code)
                    .map { [weak self] result in
                        switch result {
                        case .success:
                            if self?.currentState.isEmailExist == true {
                                self?.steps.accept(AirStep.mainTabBarIsRequired)
                            } else {
                                self?.steps.accept(AirStep.registerIsRequired)
                            }
                        case let .error(error):
                            print(error)
                            SwiftMessages.show(config: Message.airConfig, view: Message.faildView(error.message))
                        }
                    }.asObservable().flatMap { _ in Observable.empty() },
                
                Observable.just(Mutation.setLoading(false))
            ])
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .updateData(data):
            state.email = data[0]
            state.code = data[1]
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
            
        case let .updateExist(exist):
            state.isEmailExist = exist
        }
        
        return state
    }
}
