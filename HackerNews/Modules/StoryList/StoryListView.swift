//
//  StoryListView.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import SwiftUI

struct StoryListView: View {
    
    @ObservedObject var viewModel: StoryListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.stories) { story in
                    NavigationLink {
                        let viewModel = StoryDetailViewModel(id: story.id)
                        StoryDetailView(viewModel: viewModel)
                    } label: {
                        Text("\(story.title)")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hacker News")
        }
    }
    
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView(viewModel: StoryListViewModel())
    }
}
