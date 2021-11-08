//
//  GraphFlow.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import RxFlow

class GraphFlow: Flow {
    
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
            
        case .graphIsRequired:
            return navigateToGraph()
            
        default:
            return .none
        }
    }
}

extension GraphFlow {
    private func navigateToGraph() -> FlowContributors {
        let reactor = GraphViewReactor(airAuthService: services.airAuthService, userService: services.userService)
        let viewController = GraphViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
}
