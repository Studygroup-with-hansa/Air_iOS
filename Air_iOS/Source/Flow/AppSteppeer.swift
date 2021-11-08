//
//  AppSteppeer.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/07.
//

import Foundation

import RxFlow
import RxRelay


struct AppSteppeer: Stepper {
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return AirStep.splashIsRequired
    }
}
