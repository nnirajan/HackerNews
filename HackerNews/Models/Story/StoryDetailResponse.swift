//
//  StoryDetailResponse.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import Foundation

struct StoryDetailResponse: Codable, Identifiable {
    var id: Int
    var title, url: String
}
