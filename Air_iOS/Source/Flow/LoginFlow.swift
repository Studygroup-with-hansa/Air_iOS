//
//  LoginFlow.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import RxFlow

class LoginFlow: Flow {
    
    private let services: AppServices
    
    // MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.configureWithDefaultBackground()
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.standardAppearance = navigationAppearance
    }
    
    // MARK: - Init
    init(_ services: AppServices) {
        self.services = services
    }
    
    deinit {
        print("deinit \(type(of: self)) : \(#function)")
    }
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AirStep else { return .none }
        
        switch step {
        case .loginIsRequired:
            return self.navigateToLogin(authService: services.authService)
            
        case .registerIsRequired:
            return self.navigateToRegister(authService: services.authService)
            
        case .mainTabBarIsRequired:
            return .end(forwardToParentFlowWithStep: AirStep.mainTabBarIsRequired)
            
        case .dismiss:
            self.rootViewController.dismiss(animated: true, completion: nil)
            return .none
            
        case .popViewController:
            self.rootViewController.popViewController(animated: true)
            return .none
            
        case .popToRootViewController:
            self.rootViewController.popToRootViewController(animated: true)
            return .none
            
        default:
            return .none
        }
    }
    
}

extension LoginFlow {
    
    private func navigateToLogin(authService: AuthServiceType) -> FlowContributors {
        let reactor = LoginViewReactor(authService: authService)
        let viewController = LoginViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToRegister(authService: AuthServiceType) -> FlowContributors {
        let reactor = RegisterViewReactor(authService: authService)
        let viewController = RegisterViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
}
