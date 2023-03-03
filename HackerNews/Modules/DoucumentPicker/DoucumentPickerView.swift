//
//  DoucumentPickerView.swift
//  HackerNews
//
//  Created by ebpearls on 22/2/2023.
//

import SwiftUI

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

struct DoucumentPickerView: View {
    @ObservedObject var viewModel: DocumentPickerViewModel
    
    private func titleBinding(for key: Int) -> Binding<String> {
        return .init(
            get: { self.viewModel.animal.customFieldsDict[key]?.title ?? "N/A" },
            set: { self.viewModel.animal.customFieldsDict[key]?.title = $0 }
        )
    }
    
    private func detailBinding(for key: Int) -> Binding<String> {
        return .init(
            get: { self.viewModel.animal.customFieldsDict[key]?.detail ?? "N/A" },
            set: { self.viewModel.animal.customFieldsDict[key]?.detail = $0 }
        )
    }
    
    var body: some View {
        List {
            /// dictionary logic
            ForEach(viewModel.animal.customFieldsDict.keys.sorted(), id: \.self) { key in
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Title", text: titleBinding(for: key))
                        
                        TextField("Detail", text: detailBinding(for: key))
                    }

                    let files = viewModel.animal.customFieldsDict[key]?.files ?? []
                    if !files.isEmpty {
                        ForEach(files, id: \.self) { value in
                            HStack {
                                Text(value)
                                Spacer()
                                Button {
                                    if let selectedIndex = files.firstIndex(where: { $0 == value }) {
                                        viewModel.animal.customFieldsDict[key]?.files.remove(at: selectedIndex)
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
            }

            Section {
                Button("Add field") {
                    viewModel.index += 1
                    viewModel.animal.customFieldsDict[viewModel.index] = CustomFields()
                }
            }
            
            Section {
                Button("Send") {
                    debugPrint(viewModel.animal)
                }
            }
            
            /// array logic
//            ForEach(Array(viewModel.animal.customFields.enumerated()), id: \.offset) { index, customField in
//                Section {
//                    TextField("Title", text: $viewModel.animal.customFields[index].title)
//
//                    TextField("Detail", text: $viewModel.animal.customFields[index].detail)
//
//                    if customField.files.isEmpty == false {
//                        ForEach(Array(customField.files.enumerated()), id: \.offset) { fileIndex, file in
//                            HStack {
//                                Text(file)
//                                Spacer()
//                                Button {
//                                    viewModel.animal.customFields[index].files.remove(at: fileIndex)
//                                }  label: {
//                                    Image(systemName: "trash")
//                                }
//                            }
//                            .foregroundColor(.orange)
//                        }
//                    }
//
//                    Button(action: {
//                        viewModel.selectedFileType = .addSupportingFile(index)
//                        viewModel.showFileManager.toggle()
//                    }) {
//                        HStack {
//                            Image(systemName: "plus.circle")
//                            Text("Add supporting  files")
//                        }
//                    }
//                }
//            }
//
//            Section {
//                Button("Add field") {
//                    viewModel.animal.customFields.append(CustomFields())
//                }
//            }
//
//            Section {
//                Button("Send") {
//                    debugPrint(viewModel.animal)
//                }
//            }
        }
        .sheet(isPresented: $viewModel.showFileManager) {
            DocumentPicker(selectedFile: viewModel.selectedFileType, animal: $viewModel.animal)
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        DoucumentPickerView(viewModel: DocumentPickerViewModel())
    }
}
