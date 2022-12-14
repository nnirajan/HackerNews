//
//  StoryNetworkFactory.swift
//  HackerNews
//
//  Created by ebpearls on 14/12/2022.
//

import Foundation
import Combine

class StoryNetworkFactory: NetworkFactoryProtocol {
    
    // MARK: properties
    private let networking: NetworkingComformable
    
    // MARK: required initialization
    required init(_ networking: NetworkingComformable = Networking.shared) {
        self.networking = networking
    }
    
    // MARK: exec
    /// - Parameter router: StoryRouter
    /// - Returns: AnyPublisher<Data, Error>
    func exec(_ router: NetworkingRouter) -> AnyPublisher<Data, Error> {
        switch router {
        case StoryRouter.list:
            return getStoryList()
        case StoryRouter.story(let id):
            return getStoryDetail(id: id)
        default:
            assertionFailure("Invalid route send to StoryRouterFactory")
            return Fail(error: AppError.parseFailed).eraseToAnyPublisher()
        }
    }
    
    // MARK: getStoryList
    private func getStoryList() -> AnyPublisher<Data, Error> {
        let router = StoryRouter.list
        return networking.makeRequest(router: router)
    }

    // MARK: getStoryDetail
    private func getStoryDetail(id: Int) -> AnyPublisher<Data, Error> {
        let router = StoryRouter.story(id)
        return networking.makeRequest(router: router)
    }
    
}
