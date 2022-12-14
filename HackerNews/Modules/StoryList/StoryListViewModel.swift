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
    @Published var stories = [StoryDetailResponse]()
    
    private let storyNetworkFactory: StoryNetworkFactory
    
    // MARK: initization
    /// factory pattery to create story router
    init(storyNetworkFactory: StoryNetworkFactory = NetworkFactory.get(StoryNetworkFactory.self)) {
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
                self.mergeStories(storyIds: storyIds)
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
    
    // MARK: mergeStories
    func mergeStories(storyIds: [Int]) {
        var stories = [StoryDetailResponse]()
        let storyIds = Array(storyIds.prefix(50))
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let group = DispatchGroup()
            
            storyIds.forEach { id in
                group.enter()
                
                let router = StoryRouter.story(id)
                self.storyNetworkFactory.exec(router)
                    .decode(to: StoryDetailResponse.self)
                    .sink { [weak self] completion in
                        guard let self = self else { return }
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            group.leave()
                        }
                    } receiveValue: { [weak self] storyDetail in
                        guard self != nil else { return }
                        stories.append(storyDetail)
                        group.leave()
                    }.store(in: &self.bag)
            }
            
            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.stories = stories
            }
        }
    }
    
//    func getStoryById(id: Int) {
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
//    }
    
}
