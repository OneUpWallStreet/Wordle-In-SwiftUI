# Wordle In SwiftUI

This is my implementation of Wordle in SwiftUI. 

## Explaination 
I know some of the code does not really make any sense, like random completion handlers and weird Enums that really nothing at all. This is because I'm working on a iOS application and I just pulled the Wordle code from that repo (it's private) and pasted it here.

The game (application) still works, I know the implementation and logic is kinda weird. This was the first solution I came up with, and the computations are fairly inexpensive since it's only a 5 letter word game.

[Worlde.txt](https://github.com/OneUpWallStreet/Wordle-In-SwiftUI/blob/master/Wordle%20In%20SwiftUI/Models/allowedWords.txt) contains every single 5 letter word. That's what I use for making sure the input is valid.

    '''
        let path = Bundle.main.path(forResource: "allowedWords", ofType: "txt") // file path for file "data.txt"
        let allowedWordsArray = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "\n")
        let allowedWordsHashTable = Set(allowedWordsArray!)
        AllowedWordsModel.allAllowedWords = allowedWordsHashTable
    '''

Also this applications does not show any alerts, for e.g. when you enter a incorrect word, that's because in my other app the alert was represented in another SwiftUI view which was displayed with a UIHostingController(), but for this app I did not want to include any UIKit components unnecessarily so I left that part out.


## Extra 
If you have any questions/suggestions, ping me or create an issue/pull-request and I'll respond.



