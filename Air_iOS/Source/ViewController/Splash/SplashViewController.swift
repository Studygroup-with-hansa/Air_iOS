//
//  SplashViewController.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/07.
//

import UIKit
import RxViewController
import ReactorKit

class SplashViewController: BaseViewController, View {
    
    typealias Reactor = SplashViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // Image
        static let imageHeight = 61.f
        static let imageWidth = 55.f
//        static let imageY = 50.f
        
        // Title Label
        static let labelTop = 30.f
        static let labelLeft = 50.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 28, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let splashImage = UIImageView().then {
        $0.image = R.image.air_logo()
        $0.tintColor = .white
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
        
        self.view.backgroundColor = R.color.mainColor()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.splashImage)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.splashImage.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.height.equalTo(Metric.imageHeight)
            $0.center.equalToSuperview()
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: SplashViewReactor) {

        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.setNextView }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

