//
//  MainViewCell.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/01.
//

import UIKit

import ReactorKit

final class MainViewCell: BaseTableViewCell, View {
    
    typealias Reactor = MainViewCellReactor
    
    // MARK: Constants
    fileprivate struct Metric {
        // UIView
        static let colorSize = 32.f
        static let colorLeft = 20.f
        static let colorRight = 15.f
        
        // Play Image
        static let imageWidth = 13.f
        static let imageHeight = 17.f
        
        // Percent Label
        static let pecentRight = 20.f
        
        // DropDown
        static let buttonLeft = 26.f
        static let buttonWidth = 2.f
        static let buttonHeight = 8.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let timeFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let percentFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
        // MARK: - UI
    let colorView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
        $0.layer.cornerRadius = Metric.colorSize / 2
    }
    
    let playImage = UIImageView().then {
        $0.image = R.image.play_icon()
    }
    
    let titleLabel = UILabel().then {
        $0.font = Font.titleFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let timeLabel = UILabel().then {
        $0.font = Font.timeFont
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let percentLabel = UILabel().then {
        $0.font = Font.percentFont
    }
    
    let dropDownButton = UIButton(type: .system).then {
        $0.setImage(R.image.drop_down(), for: .normal)
    }
    
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        
        self.addSubview(self.colorView)
        self.colorView.addSubview(self.playImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.percentLabel)
        self.addSubview(self.dropDownButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Metric.colorLeft)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(Metric.colorSize)
        }
        
        self.playImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Metric.imageHeight)
            $0.width.equalTo(Metric.imageWidth)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.colorView.snp.right).offset(Metric.colorRight)
            $0.bottom.equalTo(self.snp.centerY)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.left.equalTo(self.colorView.snp.right).offset(Metric.colorRight)
            $0.top.equalTo(self.snp.centerY)
        }
        
        self.percentLabel.snp.makeConstraints {
            $0.right.equalTo(self.dropDownButton.snp.left).offset(-Metric.pecentRight)
            $0.centerY.equalToSuperview()
        }
        
        self.dropDownButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-Metric.buttonLeft)
            $0.width.equalTo(Metric.buttonWidth)
            $0.height.equalTo(Metric.buttonHeight)
            $0.centerY.equalToSuperview()
        }
        
    }

    // MARK: - Configuring
    
    func bind(reactor: MainViewCellReactor) {
        reactor.state.map { $0.title }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.color.hexString }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.time.toDigitString }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.percent.toPercentage + "%" }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.percentLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

