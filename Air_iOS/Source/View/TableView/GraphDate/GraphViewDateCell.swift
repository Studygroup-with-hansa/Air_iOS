//
//  GraphViewDateCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import UIKit

import ReactorKit

final class GraphViewDateCell: BaseCollectionViewCell, View {
    
    typealias Reactor = GraphViewDateReactor
    
    // MARK: Constants
    fileprivate struct Metric {
        // UIView
        static let colorViewRatio = 3.f
    }
    
    fileprivate struct Font {
        // Week Label
        static let weekFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        // Date Label
        static let dateFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - UI
    let colorView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
    }
    
    let dateLabel = UILabel().then {
        $0.font = Font.dateFont
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    
    let weekLabel = UILabel().then {
        $0.font = Font.weekFont
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.colorView)
        self.addSubview(self.weekLabel)
        self.colorView.addSubview(self.dateLabel)
        
        self.colorView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.weekLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(self.snp.height).dividedBy(Metric.colorViewRatio)
            $0.bottom.equalTo(self.colorView.snp.top)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    // MARK: - Configuring
    
    func bind(reactor: GraphViewDateReactor) {
        reactor.state.map { $0.date.toWeekDay }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.weekLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.date.toDay }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.dateLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
