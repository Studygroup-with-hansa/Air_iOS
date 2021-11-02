//
//  AppDelegate.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/15.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow
import RxViewController
import SnapKit
import CGFloatLiteral
import Rswift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = GraphViewController(reactor: GraphViewReactor(userService: UserSercice()))
        window?.rootViewController = MainViewController(reactor: MainViewReactor())
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

