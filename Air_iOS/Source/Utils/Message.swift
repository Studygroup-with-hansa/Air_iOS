//
//  Message.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/11/08.
//

import SwiftMessages

class Message {
    
    static var airConfig: SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .automatic
        config.dimMode = .none
        config.interactiveHide = true
        config.preferredStatusBarStyle = .default
        return config
    }
    
    static func successView(_ title: String) -> MessageView {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureContent(title: title, body: "")
        view.button?.isHidden = true
        
        return view
    }
    
    static func faildView(_ title: String) -> MessageView {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureContent(title: title, body: "")
        view.button?.isHidden = true
        
        return view
    }
    
}