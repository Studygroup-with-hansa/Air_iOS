//
//  MainAPI.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/15.
//

import RxSwift
import Moya

enum MainAPI {
    // Timer
    case startTimer(_ title: String)
    case stopTimer
    
    // Subject
    case getSubjectList
    case makeSubject(_ title: String, _ color: String)
    case deleteSubject(_ title: String)
    case updateSubject(_ newTitle: String, _ title: String, _ color: String)
}

extension MainAPI: BaseAPI {
    var path: String {
        switch self {
        case .startTimer:
            return "/user/timer/start/"
            
        case .stopTimer:
            return "/user/timer/start/"
            
        case .getSubjectList:
            return "/user/data/subject/"
            
        case .makeSubject:
            return "/user/data/subject/manage/"
            
        case .deleteSubject:
            return "/user/data/subject/manage/"
            
        case .updateSubject:
            return "/user/data/subject/manage/"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .startTimer(title):
            return [
                "title" : title
            ]
            
        case let .makeSubject(title, color):
            return [
                "title" : title,
                "color" : color
            ]
            
        case let .deleteSubject(title):
            return [
                "title" : title
            ]
            
        case let .updateSubject(newTitle, title, color):
            return [
                "title_new" : newTitle,
                "title" : title,
                "color" : color
            ]
            
        default:
            return nil
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSubjectList:
            return .get
            
        case .startTimer, .stopTimer, .makeSubject:
            return .post
            
        case .deleteSubject:
            return .delete
            
        case .updateSubject:
            return .put
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
