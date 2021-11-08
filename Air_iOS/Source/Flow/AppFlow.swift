//
//  AppFlow.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/07.
//

import RxFlow

class AppFlow: Flow {
    
    private let window: UIWindow
    private let services: AppServices
    
    var root: Presentable {
        return self.window
    }
    
    init(window: UIWindow, services: AppServices) {
        self.window = window
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AirStep else { return .none }
        
        switch step {
        case .splashIsRequired:
            return navigateToSplash()
            
        case .loginIsRequired:
            return navigateToLogin()
            
        case .mainTabBarIsRequired:
            return navigateToMain()
            
        default:
            return .none
            
        }
    }
    
}

extension AppFlow {
    
    private func navigateToSplash() -> FlowContributors {
        let reactor = SplashViewReactor(authService: services.authService)
        let viewController = SplashViewController(reactor: reactor)
        
        self.window.rootViewController = viewController
        UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil ,completion: nil)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow(services)
        
        Flows.use(loginFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root
            
            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: loginFlow, withNextStepper: OneStepper(withSingleStep: AirStep.loginIsRequired)))
    }
    
    private func navigateToMain() -> FlowContributors {
        let homeFlow = TabBarFlow(services)

        Flows.use(homeFlow, when: .created) { [unowned self] root in
            self.window.rootViewController = root

            UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }

        return .one(flowContributor: .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: AirStep.mainTabBarIsRequired)))
    }
}