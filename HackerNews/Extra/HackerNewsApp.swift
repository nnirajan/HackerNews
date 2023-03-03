//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    var body: some Scene {
        WindowGroup {
//            let storyViewModel = StoryListViewModel()
//            StoryListView(viewModel: storyViewModel)
            
            let vm = DocumentPickerViewModel()
            DoucumentPickerView(viewModel: vm)
        }
    }
}
