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
        
        // profile
        static let profileTop = 30.f
        static let profileSize = 80.f
        
        // Text Field
        static let textFieldHeightRatio = 12.f
        
        // Nickname Text Field
        static let nicknameTextFieldTop = 20.f
        
        // View
        static let viewSide = 30.f
    }
    
    fileprivate struct Font {
        static let profileButonFont = UIFont.systemFont(ofSize: 9, weight: .regular)
    }
    
    fileprivate struct Style {
        static let profileBorderWidth = 1.f
        static let profileBorderColor = R.color.profileBorderColor()
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
    
    let profileImage = UIButton(type: .system).then {
        $0.setBackgroundImage(R.image.profile(), for: .normal)
        $0.backgroundColor = R.color.profileBackgroundColor()
        $0.layer.cornerRadius = Metric.profileSize / 2
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = Style.profileBorderWidth
        $0.layer.borderColor = Style.profileBorderColor!.cgColor
    }
    
    let profileButton = UIButton(type: .system).then {
        $0.setTitle("프로필 사진 선택", for: .normal)
        $0.setTitleColor(R.color.mainColor(), for: .normal)
        $0.titleLabel?.font = Font.profileButonFont
    }
    
    let nicknameTextField = AirTextField().then {
        $0.titleLabel.text = "닉네임"
        $0.placeholder.text = "닉네임을 입력해주세요"
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
        self.view.addSubview(self.profileImage)
        self.view.addSubview(self.profileButton)
        self.view.addSubview(self.nicknameTextField)
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
        
        self.profileImage.snp.makeConstraints {
            $0.top.equalTo(self.backgroundView.snp.bottom).offset(Metric.profileTop)
            $0.width.height.equalTo(Metric.profileSize)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.profileButton.snp.makeConstraints {
            $0.top.equalTo(self.profileImage.snp.bottom).offset(10)
            $0.centerX.equalToSafeArea(self.view)
        }
        
        self.nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(self.profileButton.snp.bottom).offset(Metric.nicknameTextFieldTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.viewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.viewSide)
            $0.height.equalToSuperview().dividedBy(Metric.textFieldHeightRatio)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: RegisterViewReactor) {
        
    }
}
