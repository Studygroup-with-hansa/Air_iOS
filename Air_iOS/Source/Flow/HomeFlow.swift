//
//  HomeFlow.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import RxFlow

class HomeFlow: Flow {
    
    private let services: AppServices
    
    // MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.isHidden = true
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
        // 홈 화면
        case .homeIsRequired:
            return self.navigateToHome(airAuthService: services.airAuthService)
            
        default:
            return .none
        }
    }
}

extension HomeFlow {
    private func navigateToHome(airAuthService: AirAuthServiceType) -> FlowContributors {
        let reactor = MainViewReactor(airAuthService: airAuthService)
    let viewController = MainViewController(reactor: reactor)
    
    self.rootViewController.pushViewController(viewController, animated: false)
    return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
}
