//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by ebpearls on 13/12/2022.
//

import SwiftUI

struct StoryDetailView: View {
    
    @ObservedObject var viewModel: StoryDetailViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.storyDetail?.title ?? "")
            WebView(urlString: viewModel.storyDetail?.url ?? "")
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(viewModel: StoryDetailViewModel(id: 33975082))
    }
}
