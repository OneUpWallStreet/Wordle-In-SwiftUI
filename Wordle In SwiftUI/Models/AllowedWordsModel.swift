//
//  AllowedWordsModel.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import Foundation

struct AllowedWordsModel {
    static var allAllowedWords: Set<String.SubSequence> = []
    
    static func checkIfWordIsAllowed(word: Array<String>) -> Bool {
       
        var wordStr: String = ""
        
        for alphabet in word {
            wordStr.append(alphabet)
        }
        
        wordStr = wordStr.lowercased()

        if allAllowedWords.contains(Substring(wordStr)) {
            return true
        }
        else {
            return false
        }
    }
}
