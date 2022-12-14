//
//  NetworkingRouter.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation

public protocol NetworkingRouter {
    
    /// The endpoint path that will get appended to base path
    var path: String { get }
    
    /// The requests method
    var httpMethod: HTTPMethod { get }
    
}
