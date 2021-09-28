//
//  TimerViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/28.
//

import UIKit

import ReactorKit

final class TimerViewController: BaseViewController, View {
    
    typealias Reactor = TimerViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // Date Label
        static let dateLabelBottom = 5.f
        
        // Subject Label
        static let subjectLabelBottom = 10.f
        
        // To Do Label
        static let toDoLabelTop = 30.f
    }
    
    fileprivate struct Font {
        // Time Label
        static let timeLabelFont = UIFont.systemFont(ofSize: 26, weight: .medium)
        
        // Date Label
        static let dateLabelFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // Subject Label
        static let subjectLabelFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        // To Do Label
        static let toDoLabelFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    fileprivate struct Style {
        static let mainColor = UIColor.init(named: "MainColor")
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let timeLabel = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.timeLabelFont
        $0.text = "01H 47M 26S"
        $0.textColor = .white
    }
    
    let dateLabel = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.dateLabelFont
        $0.text = "2021.08.23"
        $0.textColor = .white
    }
    
    let subjectLabel = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.subjectLabelFont
        $0.text = "국어"
        $0.textColor = .white
    }
    
    let toDoLabel = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
        $0.font = Font.toDoLabelFont
        $0.text = "목표 시간 05H 00M 00S"
        $0.textColor = .white
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        super.init()
        defer {
            self.reactor = reactor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.backgroundColor = Style.mainColor
        self.view.addSubview(self.timeLabel)
        self.view.addSubview(self.dateLabel)
        self.view.addSubview(self.subjectLabel)
        self.view.addSubview(self.toDoLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.timeLabel.snp.makeConstraints {
            $0.center.equalToSafeArea(self.view)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.bottom.equalTo(self.timeLabel.snp.top).offset(-Metric.dateLabelBottom)
        }
        
        self.subjectLabel.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.bottom.equalTo(self.dateLabel.snp.top).offset(-Metric.subjectLabelBottom)
        }
        
        self.toDoLabel.snp.makeConstraints {
            $0.centerX.equalToSafeArea(self.view)
            $0.top.equalTo(self.timeLabel.snp.bottom).offset(Metric.toDoLabelTop)
        }

    }
    
    
    // MARK: - Configuring
    func bind(reactor: TimerViewReactor) {
        
    }
}

