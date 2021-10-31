//
//  GraphViewController.swift.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import UIKit

import Charts
import RxDataSources
import ReusableKit
import RxGesture
import ReactorKit

final class GraphViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = GraphViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let selectDaysHeightRatio = 8.5.f
        static let graphSizeRatio = 4.5.f
        static let graphTop = 30.f
        static let viewSide = 20.f
        static let separatorHeight = 1.f
        static let barChartViewHeightRatio = 20.f
        static let describeLabelTop = 40.f
        static let timeLabelTop = 10.f
    }
    
    fileprivate struct Font {
        static let describeLabelFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let timeLabelFont = UIFont.systemFont(ofSize: 26, weight: .bold)
    }
    
    fileprivate struct Reusable {
        static let legendCell = ReusableCell<GraphViewLegendCell>()
    }
    
    // MARK: - Properties
    fileprivate let legendDataSource: RxTableViewSectionedReloadDataSource<GraphLegendSection>
    
    // MARK: - UI
    let datePickerView = AirDatePickerView()
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.graphSeparatorColor()
    }
    
    let barView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
    }
    
    let barLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .systemBackground
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let graphView = GraphPieChart()
    
    let marker = ChartMarker()
    
    let describeLabel = UILabel().then {
        $0.textColor = R.color.mainColor()
        $0.font = Font.describeLabelFont
        $0.text = "총 공부 시간"
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = R.color.mainColor()
        $0.font = Font.timeLabelFont
    }
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.register(Reusable.legendCell)
    }
    
    // MARK: - Inintializing
    init(reactor: Reactor) {
        self.legendDataSource = Self.legendDataSourceFactory()
        super.init()
        defer {
            self.reactor = reactor
        }
    }
    
    private static func legendDataSourceFactory() -> RxTableViewSectionedReloadDataSource<GraphLegendSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
            switch sectionItem {
            case let .legend(reactor):
                let cell = tableView.dequeue(Reusable.legendCell, for: indexPath)
                cell.reactor = reactor
                return cell
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "2021.09.02"
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.datePickerView)
        self.view.addSubview(self.separatorView)
        self.view.addSubview(self.barView)
        self.barView.addSubview(self.barLabel)
        self.view.addSubview(self.describeLabel)
        self.view.addSubview(self.timeLabel)
        self.view.addSubview(self.graphView)
        self.view.addSubview(self.tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.datePickerView.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view)
            $0.height.equalToSuperview().dividedBy(Metric.selectDaysHeightRatio)
            $0.left.equalToSafeArea(self.view).offset(Metric.viewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.viewSide)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.top.equalTo(self.datePickerView.snp.bottom)
            $0.height.equalTo(Metric.separatorHeight)
            $0.left.equalToSafeArea(self.view).offset(Metric.viewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.viewSide)
        }
        
        self.barView.snp.makeConstraints {
            $0.top.equalTo(self.separatorView.snp.bottom)
            $0.left.right.equalTo(self.separatorView)
            $0.height.equalToSuperview().dividedBy(Metric.barChartViewHeightRatio)
        }
        
        self.barLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.describeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.barView.snp.bottom).offset(Metric.describeLabelTop)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.describeLabel.snp.bottom).offset(Metric.timeLabelTop)
        }
        
        self.graphView.snp.makeConstraints {
            $0.top.equalTo(self.timeLabel.snp.bottom).offset(Metric.graphTop)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.view).dividedBy(Metric.graphSizeRatio)
            $0.width.equalTo(self.graphView.snp.height)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.graphView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.left.equalToSafeArea(self.view).offset(100)
            $0.right.equalToSafeArea(self.view).offset(-100)
            $0.bottom.equalToSafeArea(self.view).offset(52)
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: GraphViewReactor) {
        
        // input
        self.view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                if !self.graphView.highlighted.isEmpty {
                    self.graphView.highlightValue(nil)
                }
            })
            .disposed(by: disposeBag)
        
        self.rx.viewDidAppear.asObservable()
            .map { _ in Reactor.Action.refreshData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map { $0.totalTime.toTimeString }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.stat?.subject }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.customizeChart(subject: $0)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { "목표 달성률 " + $0.percent + "% | " + $0.goal.toTimeString }.asObservable()
            .distinctUntilChanged()
            .bind(to: self.barLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.legendSections }.asObservable()
            .bind(to: self.tableView.rx.items(dataSource: self.legendDataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.dataClass }.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.datePickerView.reactor = AirDatePickerReactor(models: $0?.stats ?? [], userService: reactor.userService)
            })
            .disposed(by: disposeBag)
        
//        reactor.state.map { $0.currentIndex }.asObservable()
//            .distinctUntilChanged()
//            .subscribe(onNext: [weak self])
        
        // View
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak tableView] indexPath in
                tableView?.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension GraphViewController: UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionItem = self.legendDataSource[indexPath]
        
        switch sectionItem {
        case .legend:
            return 35
        }
    }
}

extension GraphViewController {
    fileprivate func customizeChart(subject: [Subject]?) {
        
        guard let subject = subject else { return }
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        for i in 0..<subject.count {
            let dataEntry = PieChartDataEntry(value: Double(subject[i].time), label: subject[i].title)
            dataEntries.append(dataEntry)
            colors.append(subject[i].color.hexString)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.sliceSpace = CGFloat(1)
        pieChartDataSet.colors = colors
        pieChartDataSet.drawValuesEnabled = false
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        self.graphView.data = pieChartData
        
        // 5. Add marker to chart
        self.marker.chartView = self.graphView
        self.graphView.marker = self.marker
    }

}
