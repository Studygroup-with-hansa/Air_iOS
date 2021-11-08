//
//  AirStep.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/07.
//

import RxFlow

enum AirStep: Step {
    case dismiss
    case popViewController
    case popToRootViewController
    
    // MARK: - Splash
    case splashIsRequired
    case loginIsRequired
    case mainTabBarIsRequired
    
    // MARK: - SignIn
    case registerIsRequired
    
    // MARK: - Home
    case homeIsRequired
    
    // MARK: - Stats
    case graphIsRequired
}
