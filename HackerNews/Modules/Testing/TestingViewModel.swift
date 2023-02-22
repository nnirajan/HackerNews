//
//  TestingViewModel.swift
//  HackerNews
//
//  Created by ebpearls on 22/2/2023.
//

import Foundation
import Combine

struct AnimalModel {
//    var customFieldsDict: [Int: CustomFields] = [0: CustomFields()] /// dict
    var customFields: [CustomFields] = [CustomFields()] /// array
}

struct CustomFields {
    var title: String = UUID().uuidString
    var detail: String = UUID().uuidString
    var files: [String] = []
}

class TestingViewModel: BaseViewModel {
    // MARK: properties
    @Published var animal: AnimalModel = AnimalModel()
    @Published var selectedFileType: SelectedFileType = .geneticReport
    @Published var index = 0
    @Published var showFileManager = false
}
