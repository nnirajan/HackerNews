//
//  MediaViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 3/3/2023.
//

import Foundation

class Animal: Codable, ObservableObject,
              Equatable /// option 3 required
{
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    /// option 3 required
    /// when there are many properities it may be difficult to check for all the types, so making equatable may be difficult
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.title != rhs.title
    }
}

class MediaViewModel: BaseViewModel {
    // MARK: properties
    @Published var animals = [Animal(title: "cat"), Animal(title: "dog")]
}
