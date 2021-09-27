//
//  AirTextField.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

import UIKit

import RxSwift
import RxCocoa

final class AirTextField: UIView {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Constants
    fileprivate struct Style {
        static let textFieldRadius = 5.f
        static let textFieldBorderWidth = 1.f
    }
    
    fileprivate struct Metric {
        static let textFieldTop = 5.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 9, weight: .regular)
        static let placeholderFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - UI
    let textField = UITextField().then {
        $0.layer.cornerRadius = Style.textFieldRadius
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = Style.textFieldBorderWidth
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.titleFont
        $0.text = "이메일"
    }
    
    let placeholder = UILabel().then {
        $0.text = "이메일을 입력해주세요"
        $0.font = Font.placeholderFont
        $0.textColor = UIColor.init(named: "TextFieldPlaceholderColor")!
    }
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.textField)
        self.textField.addSubview(self.placeholder)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.textFieldTop)
            $0.bottom.left.right.equalToSuperview()
        }
        
        self.placeholder.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
    
    fileprivate func bind() {
        self.textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.1) {
                    self.placeholder.alpha = text.isEmpty ? 1 : 0
                }
            })
            .disposed(by: disposeBag)
    }
}
