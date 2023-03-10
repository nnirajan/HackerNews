//
//  EditScreen.swift
//  HackerNews
//
//  Created by ebpearls on 10/3/2023.
//

import SwiftUI

struct EditScreen: View {
    @ObservedObject var viewModel: EditViewModel
    
    private func titleBinding() -> Binding<String> {
        return .init(
            get: { viewModel.animal?.title ?? "N/A" },
            set: { viewModel.animal?.title = $0 }
        )
    }
    
    var animalChanges: ((Animal)->Void)?
    
    var body: some View {
        viewModel.change = {
            animalChanges?(Animal(title: viewModel.animal?.title ?? "N/A"))
        }
        
        return Form {
            TextField("Title", text: titleBinding())
            
            Button("Save") {
                /// option 1
//                animalChanges?(Animal(title: viewModel.animal?.title ?? "N/A"))
                
                /// option 2
//                viewModel.makeChange()
                
                /// option 3
                viewModel.makeChangeToAnimal()
            }
        }
        /// option 3 continue
        .onChange(of: viewModel.animal) { newValue in
            animalChanges?(Animal(title: viewModel.animal?.title ?? "N/A"))
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(viewModel: EditViewModel(animal: Animal(title: "cat")))
    }
}
