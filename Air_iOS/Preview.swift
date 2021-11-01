//
//  Preview.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
//        let reactor = LoginViewReactor()
//        LoginViewController(reactor: reactor).showPreview(.iPhone13Pro)
//        LoginViewContr/oller(reactor: reactor).showPreview(.iPodTouch)
        MainViewCell().showPreview(width: 300, height: 60)
    }
}

#endif
