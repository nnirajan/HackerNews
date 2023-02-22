//
//  TestingView.swift
//  HackerNews
//
//  Created by ebpearls on 22/2/2023.
//

import SwiftUI

extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

struct TestingView: View {
    @ObservedObject var viewModel: TestingViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.animal.customFields.keys.sorted(), id: \.self) { key in
                VStack(alignment: .leading, spacing: 10) {
                    let binding: Binding<String> = Binding {
                        return $viewModel.animal.customFields.title
                    } set: {
                        viewModel.animal.customFields.title = $0
                    }
//                    TextField("hello", text: $viewModel.animal.customFields[key]?.heading)
                    
                    Text(viewModel.animal.customFields[key]?.title ?? "N/A")
                    Text(viewModel.animal.customFields[key]?.detail ?? "N/A")
                }
                
                let files = viewModel.animal.customFields[key]?.files ?? []
                if files.isEmpty == false {
                    ForEach(files, id: \.self) { value in
                        HStack {
                            Text(value)
                            Spacer()
                            Button {
                                if let selectedIndex = files.firstIndex(where: { $0 == value }) {
                                    viewModel.animal.customFields[key]?.files.remove(at: selectedIndex)
                                }
                            }  label: {
                                Image(systemName: "trash")
                            }
                        }
                        .foregroundColor(.orange)
                    }
                }
                
                Button(action: {
                    viewModel.selectedFileType = .addSupportingFile(key)
                    viewModel.showFileManager.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add supporting  files")
                    }
                }
            }
            
            Button("Add field") {
                viewModel.index += 1
                viewModel.animal.customFields[viewModel.index] = CustomFields(title: String.random(), detail: String.random(), files: [])
            }
        }
        .sheet(isPresented: $viewModel.showFileManager) {
            DocumentPicker(selectedFile: viewModel.selectedFileType, animal: $viewModel.animal)
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView(viewModel: TestingViewModel())
    }
}