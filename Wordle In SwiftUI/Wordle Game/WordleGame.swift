//
//  WordleGame.swift
//  Wordle In SwiftUI
//
//  Created by Arteezy on 2/8/22.
//

import SwiftUI

struct WordleGame: View {
    
    @ObservedObject var wordleVM: WordleGameViewModel = WordleGameViewModel()
        
    var body: some View {
        VStack{
            pauseButton
            multipleRows
            onScreenKeyBoard
            Spacer()
        }
    }
    
    var multipleRows: some View {
        VStack{
            ForEach(0..<6) { rowNumber in
                singleRow(rowNumber: rowNumber)
            }
        }
    }
    
    @ViewBuilder
    private func singleSubmittedCell(alphabet: String,rowNumber: Int,cellIndex: Int) -> some View {
        ZStack{
            let cellColor = WordleColor.getCellColor(wordleVM.guessedWordsStatus[rowNumber][cellIndex])
            VStack{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(cellColor)
                    .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)

            }
                Text(alphabet)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()

        }
    }
    
    @ViewBuilder
    private func singleUnSubmittedCell(_ alphabet: String) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color .white)
                .frame(width: SizeConstants.boxWidth, height: SizeConstants.boxHeight, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.wordleBorderGray, lineWidth: 2)
                )
            Text(alphabet)
                .font(.system(size: 40))
                .foregroundColor(.black)
                .bold()
        }    }
    
    
    @ViewBuilder
    private func singleRow(rowNumber: Int) -> some View  {
        HStack{
            ForEach(0..<5) { cellIndex in
                let alphabet = wordleVM.guessedWords[rowNumber][cellIndex]
                let cellStatus = wordleVM.guessedWordsStatus[rowNumber][cellIndex]
                if cellStatus == .edit {
                    singleUnSubmittedCell(alphabet)
                }
                else {
                    singleSubmittedCell(alphabet: alphabet, rowNumber: rowNumber, cellIndex: cellIndex)
                }
            }
        }
    }

    
    @ViewBuilder
    private func singleKeyBoardKey(alphabet: String,index: Int) -> some View {
        Button {
            wordleVM.alphabetIsSelected(alphabet)
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(wordleVM.keyboardColors[index].backgroundColorOfKeyboard)
                    .frame(width: 27.5, height: 50, alignment: .center)
                Text("\(alphabet)")
                    .foregroundColor(wordleVM.keyboardColors[index].foregroundColorOfKeyboard)
            }
        }
    }
    
    var thirdKeyBoardRow: some View {
        
        HStack{
            ForEach(18..<AlphabetsModel.allAlphabets.count+1){ index in
                if index == 18 {
                    Button {
                        let (gameStatus,_) = wordleVM.enterButtonIsPressed()
                        switch gameStatus {
                            case .alert:
                                print("Alert")
                            case .gameover:
                                wordleVM.restartGameSession()
                                print("Alert")
                            case .ignore:
                                return
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color .white)
                                .frame(width: 40, height: 50, alignment: .center)
                            Image("done")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                    }
                }
                else if index == AlphabetsModel.allAlphabets.count  {
                    Button{
                        wordleVM.backspaceButtonIsPressed()
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color .white)
                                .frame(width: 40, height: 50, alignment: .center)
                            Image("delete")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
                        }
                    }


                }
                else {
                    singleKeyBoardKey(alphabet: AlphabetsModel.allAlphabets[index], index: index)
                }
            }
            
        }
    }
    
    
    var onScreenKeyBoard: some View {
        
        VStack{
            ForEach(0..<3){ row in
                if row == 0 {
                    HStack{
                        ForEach(0..<10){ index in
                            singleKeyBoardKey(alphabet: AlphabetsModel.allAlphabets[index], index: index)
//                            singleKeyBoardKey(Alphabets.allAlphabets[index])
                        }
                    }
                }
                else if row == 1 {
                    HStack{
                        ForEach(10..<19){ index in
                            singleKeyBoardKey(alphabet: AlphabetsModel.allAlphabets[index], index: index)
                        }
                    }                }
                else {
                    thirdKeyBoardRow
                }
                
            }
        }
        .padding()


    }
    var pauseButton: some View {
        
        HStack{
            Button {
                wordleVM.restartGameSession()
            } label: {
                Image("refresh")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            Spacer()
        }
        .padding([.leading])
        .padding([.top],20)
        .padding([.bottom],5)

        
    }
    
    
    struct SizeConstants {
        static var boxWidth: CGFloat = 60
        static var boxHeight: CGFloat = 60
        static var keyboardAlphabetWidth: CGFloat = 40
        static var keyboardAlphabetHeight: CGFloat = 50
    }
}

