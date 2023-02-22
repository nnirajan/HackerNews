//
//  DocumentPicker.swift
//  YouChoosePets
//
//  Created by ebpearls on 15/02/2023.
//

import Foundation
import SwiftUI
import UIKit

enum SelectedFileType {
    case geneticReport
    case structuralReport
    case awardAchievement
    case addSupportingFile(Int)
}

struct DocumentPicker: UIViewControllerRepresentable {
    var selectedFile: SelectedFileType = .geneticReport
    
    @Binding var animal: AnimalModel
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(parent1: DocumentPicker){
            parent = parent1
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls[0].absoluteString)
            let filePath = urls[0].lastPathComponent
            print(filePath)
            switch parent.selectedFile {
            case .addSupportingFile(let index):
                if parent.animal.customFields[index]?.files.isEmpty == true {
                    parent.animal.customFields[index]?.files = [filePath]
                } else {
                    parent.animal.customFields[index]?.files.append(filePath)
                }
            default:
                break
            }
        }
    }
}
