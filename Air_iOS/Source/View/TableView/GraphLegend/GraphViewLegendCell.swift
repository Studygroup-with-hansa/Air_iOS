//
//  GraphViewLegendCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/14.
//

import UIKit

import ReactorKit

final class GraphViewLegendCell: BaseTableViewCell, View {
    
    typealias Reactor = GraphViewLegendReactor
    
    // MARK: Constants
    fileprivate struct Metric {
        // UIView
        static let viewSize = 15.f
        
        // UILable
        static let titleLeft = 10.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
        // MARK: - UI
    let colorView = UIView()
    
    let title = UILabel().then {
        $0.font = Font.titleFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        self.addSubview(self.colorView)
        self.addSubview(self.title)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.height.width.equalTo(Metric.viewSize)
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(self.colorView.snp.right).offset(Metric.titleLeft)
            $0.right.centerY.equalToSuperview()
        }
        
    }

    // MARK: - Configuring
    
    func bind(reactor: GraphViewLegendReactor) {
        reactor.state.map { $0.title }.asObservable()
            .bind(to: self.title.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.color }.asObservable()
            .bind(to: self.colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
    }
}
