//
//  NetworkFactory.swift
//  HackerNews
//
//  Created by ebpearls on 14/12/2022.
//

import Foundation
import Combine

protocol NetworkFactoryProtocol {
    init(_ networking: NetworkingComformable)
    func exec(_ router: NetworkingRouter) -> AnyPublisher<Data, Error>
}

class NetworkFactory {
    
    static func get<N:NetworkFactoryProtocol>(_ type: N.Type) -> N {
        return N(Networking.shared)
    }

}
