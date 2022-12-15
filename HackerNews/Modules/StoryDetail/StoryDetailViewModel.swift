//
//  StoryDetailViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation

class StoryDetailViewModel: BaseViewModel {
 
    // MARK: properties
    @Published var storyDetail: StoryDetailResponse?
    
    private var id: Int
    
    // MARK: initization
    init(id: Int) {
        self.id = id
        super.init()
    }
    
    // MARK: getStoryDetail
    func getStoryDetail() {
        let router = StoryRouter.story(id)
        
        networking.makeRequest(router: router).decode(to: StoryDetailResponse.self).sink { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { [weak self] storyDetail in
            guard let self = self else { return }
            self.storyDetail = storyDetail
        }.store(in: &bag)
    }
    
}
