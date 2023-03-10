//
//  MediaScreen.swift
//  HackerNews
//
//  Created by ebpearls on 3/3/2023.
//

import SwiftUI

struct MediaScreen: View {
    @ObservedObject var viewModel: MediaViewModel
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(Array(viewModel.animals.enumerated()), id: \.offset) { index, animal in
                    NavigationLink {
                        EditScreen(viewModel: EditViewModel(animal: viewModel.animals[index])) { updatedAnimal in
                            viewModel.animals[index] = animal
                        }
                    } label: {
                        Text(animal.title)
                    }

                }
            }
        }
    }
}

struct MediaScreen_Previews: PreviewProvider {
    static var previews: some View {
        MediaScreen(viewModel: MediaViewModel())
    }
}
