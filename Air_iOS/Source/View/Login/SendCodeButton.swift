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
    }
    
    fileprivate struct Font {
        
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
        self.setTitleColor(UIColor.init(named: "MainColor"), for: .normal)
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.borderColor = UIColor.init(named: "MainColor")!.cgColor
        self.layer.borderWidth = Style.borderWidth
    }
    
    override public var isHighlighted: Bool {
        didSet {
            
        }
    }
}
