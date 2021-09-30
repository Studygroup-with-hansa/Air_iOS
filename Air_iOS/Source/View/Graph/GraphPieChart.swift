//
//  GraphChartView2.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/29.
//

import UIKit
import Charts

final class GraphPieChart: PieChartView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.legend.enabled = false
        self.rotationEnabled = false
        self.holeColor = .systemBackground
        self.usePercentValuesEnabled = false
        self.drawEntryLabelsEnabled = false
        self.transparentCircleRadiusPercent = 0
        self.holeRadiusPercent = 0.5
        self.usePercentValuesEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
