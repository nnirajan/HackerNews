//
//  Publisher+Extensions.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation
import Combine

extension Publisher where Output == Data {
    
    func decode<T: Codable>(to: T.Type) -> Publishers.Decode<Self, T, JSONDecoder> {
        return decode(type: T.self, decoder: JSONDecoder())
    }
    
}
