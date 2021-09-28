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
        static let borderRadius = 5.f
        static let borderWidth = 1.f
        static let borderColor = UIColor.init(named: "TextFieldBorderColor")
        static let titleColor = UIColor.init(named: "TextFieldTitleColor")
    }
    
    fileprivate struct Metric {
        // Title
        static let titleHeight = 15.f
        
        // Border
        static let borderTop = 5.f
        
        // Side
        static let side = 10.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 9, weight: .regular)
        static let textFieldFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - UI
    var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.titleFont
        $0.textColor = Style.titleColor
    }
    
    let border = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = Style.borderRadius
        $0.layer.borderWidth = Style.borderWidth
        $0.layer.borderColor = Style.borderColor!.cgColor
    }
    
    let textField = UITextField().then {
        $0.borderStyle = .none
        $0.tintColor = UIColor.init(named: "MainColor")
        $0.font = Font.textFieldFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    var placeholder = UILabel().then {
        $0.font = Font.textFieldFont
        $0.textColor = UIColor.init(named: "TextFieldPlaceholderColor")!
        $0.adjustsFontSizeToFitWidth = true
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
        self.addSubview(self.border)
        self.border.addSubview(self.textField)
        self.border.addSubview(self.placeholder)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Metric.titleHeight)
        }
        
        self.border.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.borderTop)
            $0.bottom.left.right.equalToSuperview()
        }
        
        self.textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
        }
        
        self.placeholder.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(Metric.side)
            $0.right.equalToSuperview().offset(-Metric.side)
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
