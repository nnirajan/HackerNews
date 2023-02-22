//
//  TestingViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 22/2/2023.
//

import Foundation
import Combine

struct AnimalModel {
    var customFields: [Int: CustomFields] = [0: CustomFields()]
}

struct CustomFields {
    var title: String = String.random()
    var detail: String = String.random()
    var files: [String] = []
}

class TestingViewModel: BaseViewModel {
    // MARK: properties
    @Published var animal: AnimalModel = AnimalModel()
    @Published var selectedFileType: SelectedFileType = .geneticReport
    @Published var index = 0
    @Published var showFileManager = false
}
