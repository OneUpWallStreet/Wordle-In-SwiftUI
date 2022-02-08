//
//  SecretWordModel.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import Foundation

class SecretWordModel {
    
    static let mainSecretWordInstance = SecretWordModel()
    
//  This is just the default value
    var secretWord: Array<String> = ["D","R","U","N","K"] {
        didSet {
            secretWordString = secretWord.convertArrayToString()
        }
    }
    
    var randomWords: Array<Array<String>> = [["C","L","I","C","K"],["L","I","G","H","T"],["O","T","H","E","R"],["P","H","O","N","E"]]
    
    var secretWordString: String = "DRUNK"
    
    /// Changes the secret word for the user when he presses play
    /// - Parameter completion: returns weather changing word was succesful
    func generateNewWord(completion: @escaping (Bool) -> Void) {
        
        
//      random element only returns nil if collection is empty, which should never be the case since we initialized it with 4 values
        secretWord = randomWords.randomElement()!
        print("changed Word: \(secretWord)")
        completion(true)
    }
    
}
