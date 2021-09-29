//
//  GraphViewController.swift.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import UIKit

import Charts
import ReactorKit

final class GraphViewController: BaseViewController, View {
    
    typealias Reactor = GraphViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        static let selectDaysHeightRatio = 8.5.f
        static let graphSizeRatio = 4.5.f
        static let viewSide = 20.f
        static let separatorHeight = 1.f
        static let barChartViewHeightRatio = 20.f
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - Properties
    
    // MARK: - UI
    let selectDays = UIView().then {
        $0.backgroundColor = .white
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = R.color.graphSeparatorColor()
    }
    
    let barView = UIView().then {
        $0.backgroundColor = R.color.mainColor()
    }
    
    let barLabel = UILabel().then {
        $0.text = "목표 달성률 50% | 05H 00M 00S"
        $0.textAlignment = .center
        $0.textColor = .systemBackground
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let graphView = GraphPieChart()
    
    let marker = ChartMarker()
    
    let scrollView = UIScrollView()
    
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
        
        self.navigationController?.navigationBar.barTintColor = R.color.mainColor()
        self.title = "2021.09.02"
        
        let subjects = ["국어 : 1H 2M 00S", "수학 : 1H 2M 00S", "영어 : 1H 2M 00S", "기타 : 1H 2M 00S"]
        let times = [1, 1, 1, 1]
        let colors: [UIColor] = [.cyan, .green, .brown, .magenta]
        
        customizeChart(dataPoints: subjects, values: times.map { Double($0) }, colors: colors)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(self.selectDays)
        self.view.addSubview(self.separatorView)
        self.view.addSubview(self.barView)
        self.barView.addSubview(self.barLabel)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.graphView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if !self.graphView.highlighted.isEmpty {
            self.graphView.highlightValue(nil)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.selectDays.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view)
            $0.height.equalToSuperview().dividedBy(Metric.selectDaysHeightRatio)
            $0.left.equalToSafeArea(self.view).offset(Metric.viewSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.viewSide)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.top.equalTo(self.selectDays.snp.bottom)
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
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.barView.snp.bottom)
            $0.left.right.bottom.equalToSafeArea(self.view)
        }
        
        self.graphView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(1500)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.view).dividedBy(Metric.graphSizeRatio)
            $0.width.equalTo(self.graphView.snp.height)
            $0.bottom.equalToSuperview().offset(-1500)
        }
        
    }
    
    // MARK: - Configuring
    func bind(reactor: GraphViewReactor) {
        
    }
}

extension GraphViewController {
    fileprivate func customizeChart(dataPoints: [String], values: [Double], colors: [UIColor]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.sliceSpace = CGFloat(2)
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
