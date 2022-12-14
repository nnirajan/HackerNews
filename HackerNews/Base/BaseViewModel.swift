//
//  BaseViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    // MARK: propertites
    /// The subcription cleanup bag
    public var bag: Set<AnyCancellable>
    
    let networking = Networking.shared
    
    @Published var errorMessage: String = ""
    
    // MARK: initialization
    public init() {
        self.bag = Set<AnyCancellable>()
    }
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
    
}
