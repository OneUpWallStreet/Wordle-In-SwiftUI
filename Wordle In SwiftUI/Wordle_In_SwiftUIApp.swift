//
//  Wordle_In_SwiftUIApp.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    /// Initialize model of all the allowed words  Text conversion code from -> https://stackoverflow.com/a/24098109/14918173
    private func initializeAllowedWords() {
        
        let path = Bundle.main.path(forResource: "allowedWords", ofType: "txt") // file path for file "data.txt"
//      Read from file as an array
        let allowedWordsArray = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "\n")
//      Conver to hash table
        let allowedWordsHashTable = Set(allowedWordsArray!)
        
//      initialise global model
        AllowedWordsModel.allAllowedWords = allowedWordsHashTable
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initializeAllowedWords()
        return true
    }
}

@main
struct Wordle_In_SwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            WordleGame()
        }
    }
}
