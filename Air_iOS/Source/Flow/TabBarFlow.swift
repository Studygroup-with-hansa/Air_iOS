//
//  TabBarFlow.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import UIKit
import RxFlow

final class TabBarFlow: Flow {
    
    private var rootViewController: UITabBarController
    private let services: AppServices
    
    var root: Presentable {
        return rootViewController
    }
    
    init(_ services: AppServices) {
        self.rootViewController = TabBarViewController()
        self.services = services
    }
    
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AirStep else { return .none }
        
        switch step {
        case .mainTabBarIsRequired:
            return .none
//            return navigateToTabBar()
            
        case .splashIsRequired:
            return .end(forwardToParentFlowWithStep: AirStep.splashIsRequired)
            
        default:
            return .none
        }
    }
}

extension TabBarFlow {
    private func navigateToTabBar() -> FlowContributors {
        let homeFlow = HomeFlow(self.services)
        let graphFlow = GraphFlow(self.services)

        Flows.use(homeFlow, graphFlow, when: .created) { [unowned self] (root1, root2: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "홈", image: UIImage(systemName: "Home"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1

            let tabBarItem2 = UITabBarItem(title: "설정", image: UIImage(systemName: "gears"), selectedImage: nil)
            root2.tabBarItem = tabBarItem2

            self.rootViewController.setViewControllers([root1, root2], animated: false)
        }

        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow,
                        withNextStepper: OneStepper(withSingleStep: AirStep.homeIsRequired)),

            .contribute(withNextPresentable: graphFlow,
                        withNextStepper: OneStepper(withSingleStep: AirStep.graphIsRequired))
        ])
    }
}
