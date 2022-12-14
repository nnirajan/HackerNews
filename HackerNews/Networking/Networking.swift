//
//  Networking.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation
import Combine

protocol NetworkingComformable {
    func makeRequest(router: NetworkingRouter) -> AnyPublisher<Data, Error>
}

class Networking: NetworkingComformable {
    
    // MARK: properties
    private let baseURL = "https://hacker-news.firebaseio.com/v0/"
    
    static let shared = Networking()
    
    // MARK: initialization
    private init() {}
    
    // MARK: makeRequest
    func makeRequest(router: NetworkingRouter) -> AnyPublisher<Data, Error> {
        let urlString = baseURL + router.path
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession.shared.dataTaskPublisher(for: url)
        return session.receive(on: RunLoop.main).mapError { error in
            return error
        }.map { data, response in
            return data
        }.eraseToAnyPublisher()
    }
    
}
