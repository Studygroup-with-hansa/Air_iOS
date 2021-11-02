//
//  MainSection.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/02.
//

import RxDataSources

enum MainSection {
    case mainCell([MainSectionItem])
}

extension MainSection: SectionModelType {
    typealias Item = MainSectionItem
    
    var items: [MainSectionItem] {
        switch self {
        case let .mainCell(items):
            return items
        }
    }
    
    init(original: MainSection, items: [MainSectionItem]) {
        switch original {
        case let .mainCell(items):
            self = .mainCell(items)
        }
    }
}

enum MainSectionItem {
    case mainCell(MainViewCellReactor)
}
