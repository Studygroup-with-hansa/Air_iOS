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
        // Background
        static let backgroundRatio = 2.75.f
        
        // View
        static let viewSide = 30.f
        
        // Image
        static let logoImageHeight = 62.f
        static let logoImageWidth = 55.f
        
        // Email
        static let emailTextFieldTop = 50.f
        
        // Code
        static let codeTextFieldTop = 10.f
        
        // Text Field
        static let textFieldHeightRatio = 12.f
        
        // Login
        static let loginButtonHeight = 40.f
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
    
    let emailTextField = AirTextField().then {
        $0.titleLabel.text = "이메일"
        $0.placeholder.text = "이메일을 입력해주세요"
    }
    
    let sendCodeButton = SendCodeButton()
    
    let codeTextField = AirTextField().then {
        $0.titleLabel.text = "인증코드"
        $0.placeholder.text = "인증 코드를 입력해주세요"
    }
    
    let loginButton = AirPlainButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
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
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.sendCodeButton)
        self.view.addSubview(self.codeTextField)
        self.view.addSubview(self.loginButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.backgroundView.snp.makeConstraints {
            // equal to top
            $0.top.right.left.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(Metric.backgroundRatio)
        }
        
        self.logoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Metric.logoImageHeight)
            $0.width.equalTo(Metric.logoImageWidth)
        }
        
        self.emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.backgroundView.snp.bottom).offset(Metric.emailTextFieldTop)
            $0.left.equalToSuperview().offset(Metric.viewSide)
            $0.right.equalTo(self.sendCodeButton.snp.left).offset(-15)
            $0.height.equalToSuperview().dividedBy(Metric.textFieldHeightRatio)
        }
        
        self.sendCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(emailTextField)
            $0.right.equalToSuperview().offset(-Metric.viewSide)
            $0.height.equalToSuperview().dividedBy(Metric.textFieldHeightRatio).offset(-20)
            $0.width.equalTo(55)
        }
        
        self.codeTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(Metric.codeTextFieldTop)
            $0.left.equalToSuperview().offset(Metric.viewSide)
            $0.right.equalToSuperview().offset(-Metric.viewSide)
            $0.height.equalToSuperview().dividedBy(Metric.textFieldHeightRatio)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Metric.viewSide)
            $0.trailing.equalToSuperview().offset(-Metric.viewSide)
            $0.height.equalTo(Metric.loginButtonHeight)
            $0.bottom.equalToSafeArea(self.view).offset(-30)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: LoginViewReactor) {
        
    }
}
