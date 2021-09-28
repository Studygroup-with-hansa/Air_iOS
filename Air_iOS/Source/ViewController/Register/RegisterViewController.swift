//
//  RegisterViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/28.
//

import UIKit

import ReactorKit

final class RegisterViewController: BaseViewController, View {
    
    typealias Reactor = RegisterViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // logo
        static let logoHeight = 40.f
        static let logoWidth = 36.f
        static let logoBottom = 25.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let backgroundView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
    }
    
    let logoImage = UIImageView().then {
        $0.image = R.image.air_logo()
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
            $0.top.right.left.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(6)
        }
        
        self.logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Metric.logoBottom)
            $0.height.equalTo(Metric.logoHeight)
            $0.width.equalTo(Metric.logoWidth)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: RegisterViewReactor) {
        
    }
}
