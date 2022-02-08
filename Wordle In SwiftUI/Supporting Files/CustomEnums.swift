//
//  CustomEnums.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import Foundation
import SwiftUI

enum AlertType {
    case notInList
    case incompleteWord
}

/// Gray, Yellow, Green show details about the chosen word, edit means that row is still being edited by the user
enum WordleColor {
    case gray
    case yellow
    case green
    case edit
    
    static func getCellColor(_ status: WordleColor) -> Color {
        
        switch status {
        case .gray:
            return Color.wordleGray
        case .yellow:
            return Color.wordleYellow
        case .green:
            return Color.wordleGreen
//      Should never be in .edit, can ignore this case, returning garbage value
        case .edit:
//          Random Value
            return Color.black
        }
    }
}

enum GameStatusForManagingDelegate {
    case alert
    case gameover
    case ignore
}
