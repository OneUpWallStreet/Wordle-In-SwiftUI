//
//  WordleGameViewModel.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import Foundation
import SwiftUI



struct AlphabetStatus {
    var alphabet: String
    var status: WordleColor
}

struct KeyboardColor {
    let backgroundColorOfKeyboard: Color
    let foregroundColorOfKeyboard: Color
}



class WordleGameViewModel: ObservableObject {
    
    @Published var guessedWords: Array<Array<String>> = [["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""]]

    @Published var guessedWordsStatus: Array<Array<WordleColor>> = [[.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                    [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                    [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit]]
    
    @Published var keyboardColors: Array<KeyboardColor> = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .wordleIdleGray, foregroundColorOfKeyboard: .black), count: AlphabetsModel.allAlphabets.count)
    
    
    @Published var usedAlphabets: Array<AlphabetStatus> = []
    
        
    var secretWord: Array<String> = SecretWordModel.mainSecretWordInstance.secretWord
 
    @Published var currentRow = 0
    @Published var currentIndex = 0
    @Published var isSpaceFullInCurrentRow: Bool = false
    
    /// Restarts the game chaning the secret word, and removing all the local data about the current gameplay status
    func restartGameSession() {
        let secretWordManager = SecretWordModel.mainSecretWordInstance
        secretWordManager.generateNewWord { wordChangeStatus in
            if wordChangeStatus {
                DispatchQueue.main.async {
                    self.guessedWords = [["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""],["","","","",""]]
                    self.guessedWordsStatus = [[.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                                [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit],
                                                                                [.edit,.edit,.edit,.edit,.edit],[.edit,.edit,.edit,.edit,.edit]]
                    self.keyboardColors = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .wordleIdleGray, foregroundColorOfKeyboard: .black), count: AlphabetsModel.allAlphabets.count)
                    self.usedAlphabets = []
                    self.isSpaceFullInCurrentRow = false
                    self.currentIndex = 0
                    self.currentRow = 0
                    self.secretWord = secretWordManager.secretWord
                }
            }
        }
    }
    
    func checkSingleRow() {
                
        let guessedWord: Array<String> = guessedWords[currentRow]
        var availableAlphabets: Array<String> = secretWord

        for (index,alphabet) in guessedWord.enumerated() {
            if secretWord.contains(alphabet) && guessedWord[index] == secretWord[index]  {
                guessedWordsStatus[currentRow][index] = .green
                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleGreen, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet)
            }
            
        }
        
        for (index,alphabet) in guessedWord.enumerated() {
            
            if secretWord.contains(alphabet) == false {
                guessedWordsStatus[currentRow][index] = .gray
                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleGray, foregroundColorOfKeyboard: .white)

            }
            
            else if secretWord.contains(alphabet) && guessedWord[index] != secretWord[index] && availableAlphabets.contains(alphabet) {
                guessedWordsStatus[currentRow][index] = .yellow
                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet)] = KeyboardColor(backgroundColorOfKeyboard: .wordleYellow, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet)
            }
            
            else if secretWord.contains(alphabet) && guessedWord[index] != secretWord[index] && availableAlphabets.contains(alphabet) == false {
                guessedWordsStatus[currentRow][index] = .gray
            }
            
        }
        
    }

    
    func isWordAllowed() -> Bool {
        return AllowedWordsModel.checkIfWordIsAllowed(word: guessedWords[currentRow])
    }
    
    /// Enter/Submit button is pressed on the on screen keyboard
    func enterButtonIsPressed() -> (GameStatusForManagingDelegate,AlertType?){
//      Go To Next Row, or the game is over
        if currentIndex == 4 && isSpaceFullInCurrentRow == true {
            
            if isWordAllowed() == true {
                checkSingleRow()
//              Do this is you check row 1 through 4
                if currentRow != 5 {
                    
                    print("guessedWords[currentRow].convertArrayToString() \(guessedWords[currentRow].convertArrayToString())")
                    print("SecretWordModel.mainSecretWordInstance.secretWordString \(SecretWordModel.mainSecretWordInstance.secretWordString)")
//                  Check if user won
                    if guessedWords[currentRow].convertArrayToString() == SecretWordModel.mainSecretWordInstance.secretWordString {
                        print("In game over")
                        return (.gameover,nil)
                    }
                    
                    currentRow += 1
                    currentIndex = 0
                    isSpaceFullInCurrentRow = false
                    
                    return (.ignore,nil)
                }
//              Do this if you just checked the last row and now game is over
                else {
                    return (.gameover,nil)
                }
            }
            else {
                return (.alert,.notInList)
            }
        }
        else {
            return (.alert,.incompleteWord)
        }
    }
    
    /// Backspace button is pressed on the on screen keyboard
    func backspaceButtonIsPressed() {
        
        isSpaceFullInCurrentRow = false
        if guessedWords[currentRow][currentIndex] != "" {
            guessedWords[currentRow][currentIndex] = ""
        }
        else {
            if currentIndex != 0 {
                currentIndex -= 1
                guessedWords[currentRow][currentIndex] = ""

            }
        }
    }
    
    /// A button on the on-screen keyboard is pressed
    /// - Parameter alphabet: letter between -> A To Z
    func alphabetIsSelected(_ alphabet: String) {
        
        if self.isSpaceFullInCurrentRow == true {
            return
        }
        
        self.guessedWords[self.currentRow][self.currentIndex] = alphabet
        
        if self.currentIndex == 4 {
            self.isSpaceFullInCurrentRow = true
        }
        else {
            self.currentIndex += 1
        }
    }
    
}
