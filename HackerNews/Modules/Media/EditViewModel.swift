//
//  EditViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 10/3/2023.
//

import Foundation

class EditViewModel: BaseViewModel {
    // MARK: properties
    @Published var animal: Animal?
    
    var change: (()->Void)?
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    func makeChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.change?()
        }
    }
    
    func makeChangeToAnimal() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animal = self.animal
        }
    }
}
