//
//  Alphabets.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import Foundation


struct AlphabetsModel {
    
    static var allAlphabets: Array<String> = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D",
                                              "F","G","H","J","K","L","Z","X","C","V","B","N","M"]
        
    static func getIndexOfAlphabet(_ alphabet: String) -> Int{
        return allAlphabets.firstIndex(of: alphabet)!
    }
    
}
