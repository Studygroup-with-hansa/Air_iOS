//
//  AirDatePickerView.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/25.
//

import UIKit

import ReactorKit

final class AirDatePickerView: UIView, View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = AirDatePickerReactor
    
    // MARK: - Properties
    
    // MARK: - Constants
    fileprivate struct Metric {
        
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
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
        
        self.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    func bind(reactor: AirDatePickerReactor) {
        reactor.state.map { $0.stats }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                $0.enumerated().forEach {
                    self.stackView.insertArrangedSubview(self.createCell($1, $0), at: $0)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AirDatePickerView {
    
    private func createCell( _ stat: Stat, _ index: Int) -> DatePickerDateCell {
        let datecell = DatePickerDateCell().then {
            $0.reactor = DatePickerDateReactor(model: stat, index: index, userService: reactor!.userService)
        }
        return datecell
    }
    
}
