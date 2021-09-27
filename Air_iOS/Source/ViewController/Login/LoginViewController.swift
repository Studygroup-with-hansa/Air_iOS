//
//  LoginViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//


import UIKit

import ReactorKit

final class LoginViewController: BaseViewController, View {
    
    typealias Reactor = LoginViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let backgroundRatio = 2.75.f
        
        static let logoImageHeight = 62.f
        static let logoImageWidth = 55.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let backgroundView = UIView().then {
        $0.backgroundColor = .init(named: "MainColor")
    }
    
    let logoImage = UIImageView().then {
        $0.image = UIImage.init(named: "Air_logo")
        $0.tintColor = .white
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        super.init()
        defer {
            self.reactor = reactor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.logoImage)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.backgroundView.snp.makeConstraints {
            // equal to top
            $0.top.equalToSuperview().offset(-(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(Metric.backgroundRatio)
        }
        
        self.logoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Metric.logoImageHeight)
            $0.width.equalTo(Metric.logoImageWidth)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: LoginViewReactor) {
        
    }
}
