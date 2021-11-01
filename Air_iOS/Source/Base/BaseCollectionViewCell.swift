//
//  BaseCollectionViewCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // MARK: Sub init
    required convenience init?(coder: NSCoder) {
        self.init(frame: .zero)
    }
}
