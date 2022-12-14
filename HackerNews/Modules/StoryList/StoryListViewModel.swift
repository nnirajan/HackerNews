//
//  StoryListViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation
import Combine

class StoryListViewModel: BaseViewModel {
    
    // MARK: properties
    @Published var stories = [StoryListResponse]()
    
    var storyNetworkFactory: StoryNetworkFactory
    
    // MARK: initization
    /// factory pattery to create story router
    init(stories: [StoryListResponse] = [StoryListResponse](), storyNetworkFactory: StoryNetworkFactory = NetworkFactory.get(StoryNetworkFactory.self)) {
        self.stories = stories
        self.storyNetworkFactory = storyNetworkFactory
        super.init()
        getStoryList()
    }
    
    // MARK: getStoryList
    /// get story list
    func getStoryList() {
        let router = StoryRouter.list
        storyNetworkFactory.exec(router)
            .decode(to: [Int].self)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] storyIds in
                guard let self = self else { return }
                self.stories = storyIds.map { StoryListResponse(id: $0) }
                self.getStoryById(id: self.stories[0].id)
            }.store(in: &bag)
        
//        networking.makeRequest(router: router)
//            .receive(on: RunLoop.main)
//            .decode(to: [Int].self)
//            .sink { [weak self] completion in
//                guard let self = self else { return }
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            } receiveValue: { [weak self] storyIds in
//                guard let self = self else { return }
//                self.stories = storyIds.map { StoryListResponse(id: $0) }
//                self.getStoryById(id: self.stories[0].id)
//            }.store(in: &bag)
    }
    
    func getStoryById(id: Int) {
        let router = StoryRouter.story(id)
        storyNetworkFactory.exec(router)
            .decode(to: StoryDetailResponse.self)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] storyDetail in
                guard let self = self else { return }
            }.store(in: &bag)
        
//        networking.makeRequest(router: router)
//            .decode(to: StoryDetailResponse.self)
//            .sink { [weak self] completion in
//                guard let self = self else { return }
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            } receiveValue: { [weak self] storyDetail in
//                guard let self = self else { return }
//            }.store(in: &bag)
    }
    
}
