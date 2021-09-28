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
        static let mainColor = R.color.mainColor()
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
        self.setTitleColor(Style.mainColor, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.setTitleColor(.lightGray, for: .disabled)
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.borderColor = Style.mainColor!.cgColor
        self.layer.borderWidth = Style.borderWidth
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.isHighlighted ? Style.mainColor : .clear
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.layer.borderColor = self.isEnabled ? Style.mainColor!.cgColor : UIColor.lightGray.cgColor
            }
        }
    }
}
