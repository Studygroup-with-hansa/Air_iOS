//
//  AirPlainButton.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/28.
//

import UIKit
import SwiftUI

final class AirPlainButton: UIButton {
    
    // MARK: - Constants
    fileprivate struct Style {
        static let cornerRadius = 5.f
        static let borderWidth = 1.f
        static let mainColor = R.color.mainColor()
        static let borderColor = R.color.buttonBorderColor()
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
        
        self.backgroundColor = Style.mainColor
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.borderWidth = Style.borderWidth
        self.layer.borderColor = Style.borderColor!.cgColor
        self.titleLabel?.font = Font.titleFont
    }
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.6 : 1
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.isEnabled ? Style.mainColor : .lightGray
            }
        }
    }
    
}
