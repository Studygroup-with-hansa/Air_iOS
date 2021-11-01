//
//  BaseTableViewCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/14.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Sub init
    required convenience init?(coder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }

}
