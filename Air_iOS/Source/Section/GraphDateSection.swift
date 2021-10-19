//
//  GraphDateSection.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/10/17.
//

import RxDataSources

enum GraphDateSection {
    case date([GraphDateSectionItem])
}

extension GraphDateSection: SectionModelType {
    typealias Item = GraphDateSectionItem
    
    var items: [GraphDateSectionItem] {
        switch self {
        case let .date(items):
            return items
        }
    }
    
    init(original: GraphDateSection, items: [GraphDateSectionItem]) {
        switch original {
        case let .date(items):
            self = .date(items)
        }
    }
    
}

enum GraphDateSectionItem {
    case date(GraphViewDateReactor)
}
