//
//  HTTPMethod.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation

/// The web http request methods
public enum HTTPMethod {
    
    case get, post, put, delete, patch
    
    var identifier: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        case .patch: return "PATCH"
        }
    }
}
