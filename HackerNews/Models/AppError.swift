//
//  AppError.swift
//  HackerNews
//
//  Created by ebpearls on 14/12/2022.
//

import Foundation

enum AppError: LocalizedError {
    case parseFailed
    
    var errorDescription: String? {
        switch self {
        case .parseFailed:
            return "Parse Failed"
        }
    }
    
    var code: Int {
        return 0
    }
}
