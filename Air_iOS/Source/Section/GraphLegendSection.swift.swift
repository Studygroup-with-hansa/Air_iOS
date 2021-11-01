//
//  GraphLegendSection.swift.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/14.
//

import RxDataSources

enum GraphLegendSection {
    case legend([GraphLegendSectionItem])
}

extension GraphLegendSection: SectionModelType {
    typealias Item = GraphLegendSectionItem
    
    var items: [GraphLegendSectionItem] {
        switch self {
        case let .legend(items):
            return items
        }
    }
    
    init(original: GraphLegendSection, items: [GraphLegendSectionItem]) {
        switch original {
        case let .legend(items):
            self = .legend(items)
        }
    }
    
}

enum GraphLegendSectionItem {
    case legend(GraphViewLegendReactor)
}
