//
//  StoryRouter.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation

enum StoryRouter: NetworkingRouter {
    case list
    case story(Int)
    
    var path: String {
        switch self {
        case .list:
            return "topstories.json?print=pretty"
        case .story(let id):
            return "item/\(id).json?print=pretty"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
