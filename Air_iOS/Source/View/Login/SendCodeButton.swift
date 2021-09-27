//
//  SendCodeButton.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

import UIKit

final class SendCodeButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let borderWidth = 1.f
        static let cornerRadius = 5.f
        static let MainColor = UIColor.init(named: "MainColor")
    }
    
    fileprivate struct Font {
        static let buttonTitle = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - UI
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setTitle("인증", for: .normal)
        self.titleLabel?.font = Font.buttonTitle
        self.setTitleColor(Style.MainColor, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.borderColor = UIColor.init(named: "MainColor")!.cgColor
        self.layer.borderWidth = Style.borderWidth
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.isHighlighted ? Style.MainColor : .clear
            }
        }
    }
}
