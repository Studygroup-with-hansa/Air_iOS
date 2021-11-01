//
//  MainViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/01.
//

import UIKit

import ReactorKit
import RxViewController

final class MainViewController: BaseViewController, View {
    
    typealias Reactor = MainViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let colorViewRatio = 3.5.f
        static let addButtonSize = 24.f
        static let viewSide = 20.f
        static let dateLabelBottom = 10.f
        static let goalLabelTop = 30.f
    }
    
    fileprivate struct Font {
        static let mainLabelFont = UIFont.systemFont(ofSize: 26, weight: .medium)
        static let subLabelFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    fileprivate struct Style {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let colorView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
    }
    
    let dateLabel = UILabel().then {
        $0.font = Font.subLabelFont
        $0.textColor = .white
        $0.text = Date().dateString
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = Font.mainLabelFont
    }
    
    let goalLabel = UILabel().then {
        $0.textColor = .white
        $0.font = Font.subLabelFont
    }
    
    let titleLabel = UILabel().then {
        $0.text = "과목"
        $0.font = Font.titleFont
    }
    
    let addButton = UIButton(type: .system).then {
        $0.setImage(R.image.plus_button_icon(), for: .normal)
    }
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
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
        
        self.view.addSubview(self.colorView)
        self.colorView.addSubview(self.dateLabel)
        self.colorView.addSubview(self.timeLabel)
        self.colorView.addSubview(self.goalLabel)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.colorView.snp.makeConstraints {
            $0.top.left.right.equalToSafeArea(self.view)
            $0.height.equalToSuperview().dividedBy(Metric.colorViewRatio)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.timeLabel.snp.top).offset(-Metric.dateLabelBottom)
            $0.centerX.equalToSuperview()
        }
        
        self.goalLabel.snp.makeConstraints {
            $0.top.equalTo(self.timeLabel.snp.bottom).offset(Metric.goalLabelTop)
            $0.centerX.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.colorView.snp.bottom).offset(Metric.viewSide)
            $0.left.equalToSuperview().offset(Metric.viewSide)
        }
        
        self.addButton.snp.makeConstraints {
            $0.height.width.equalTo(Metric.addButtonSize)
            $0.centerY.equalTo(self.titleLabel)
            $0.right.equalToSuperview().offset(-Metric.viewSide)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            $0.left.right.bottom.equalToSafeArea(self.view)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: MainViewReactor) {
        
        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.refreshData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.totalTime.toTimeString }.asObservable()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { "목표시간 " + $0.goal.toTimeString }.asObservable()
            .bind(to: self.goalLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}

