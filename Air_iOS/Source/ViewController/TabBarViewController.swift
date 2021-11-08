//
//  TabBarViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import UIKit
import RxSwift

class TabBarViewController: UITabBarController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.barTintColor = .secondarySystemBackground
                
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .default
        
        self.tabBar.frame.size.height = 95

    }
    
}
