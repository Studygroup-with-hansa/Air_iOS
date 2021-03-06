//
//  DatePickerDateCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import UIKit

import RxGesture
import ReactorKit

final class DatePickerDateCell: UIView, ReactorKit.View {
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.colorView)
        self.addSubview(self.weekLabel)
        self.colorView.addSubview(self.dateLabel)
        
        self.colorView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(self.colorView.snp.width)
        }
        
        self.weekLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(self.colorView.snp.top)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    // MARK: - Configuring
    
    func bind(reactor: DatePickerDateReactor) {
        
        self.rx.tapGesture()
            .when(.recognized)
            // defualt index is 6
            .map { _ in Reactor.Action.changeIndex(self.reactor?.currentState.index ?? 6) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.date.toWeekDay }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.weekLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.date.toDay }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.achievementRate }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 == 0 {
                    self.colorView.backgroundColor = self.colorView.backgroundColor?.withAlphaComponent(0)
                    self.dateLabel.textColor = .black
                } else {
                    self.colorView.backgroundColor = self.colorView.backgroundColor?.withAlphaComponent(0.3 + $0 / 1000 * 7)
                    self.dateLabel.textColor = .white
                }
            })
            .disposed(by: disposeBag)
    }
}
