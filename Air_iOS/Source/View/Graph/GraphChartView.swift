//
//  GraphChartView.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import UIKit
import Charts

final class GraphChartView: UIView {
    
    // MARK: - Constants
    fileprivate struct Style {
        
    }
    
    fileprivate struct Font {
        
    }
    
    // MARK: - UI
    let chart = PieChartView().then {
        $0.legend.enabled = false
        $0.rotationEnabled = false
        $0.transparentCircleColor = .clear
        $0.holeColor = .systemBackground
        $0.usePercentValuesEnabled = false
        $0.drawEntryLabelsEnabled = false
    }
    
    let marker = ChartMarker()
    
    // MARK: - Inititalizing
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let subjects = ["국어 : 1H 2M 00S", "수학 : 1H 2M 00S", "영어 : 1H 2M 00S", "기타 : 1H 2M 00S"]
        let times = [1, 1, 1, 1]
        let colors: [UIColor] = [.cyan, .green, .brown, .magenta]
        
        customizeChart(dataPoints: subjects, values: times.map { Double($0) }, colors: colors)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.chart)
        
        self.chart.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func customizeChart(dataPoints: [String], values: [Double], colors: [UIColor]) {
        
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
        self.chart.data = pieChartData
        
        // 5. Add marker to chart
        self.marker.chartView = self.chart
        self.chart.marker = self.marker
    }
    
}
