//
//  ContentView.swift
//  WorddScramble
//
//  Created by Tan Xin Jie on 26/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var possibleWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var isGameOver = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section(header: Text("Guess the words")) {
                    ForEach(possibleWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            if !isGameOver {
                                Text(usedWords.contains(word) ? word : String(repeating: "*", count: word.count))
                            } else {
                                Text(word)
                            }
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isGameOver {
                            startGame()
                        }
                        isGameOver.toggle()
                    }) {
                        Text(isGameOver ? "Reset" : "Give Up")
                            .foregroundColor(isGameOver ? .secondary : .red)
                    }
                }
            })
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word is used", message: "Use a different word!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word is not possible", message: "'\(answer)' not found in your '\(rootWord)'")
            return
        }
        guard isShort(word: answer) else {
            wordError(title: "Word is too short", message: "Minimum word length is 3.")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word does not exists", message: "Try again!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            if usedWords.count == possibleWords.count {
                wordError(title: "Congratulations", message: "You successfully guessed all the words. Press reset to play again")
                isGameOver = true
            }
        }
        
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isShort(word: String) -> Bool {
        !(word.count < 3)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspellRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame(){
        if let startWorldURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWorldURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                findPossibleWords()
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func findPossibleWords() {
        possibleWords = []
        let rootLetters = Array(rootWord)
        let wordLength = rootLetters.count
        
        for start in 0..<wordLength {
            for end in start+1...wordLength {
                let substring = String(rootLetters[start..<end])
                
                if substring != rootWord && substring.count >= 3 && isReal(word: substring) && !possibleWords.contains(substring) {
                    possibleWords.append(substring)
                }
            }
        }
        possibleWords.sort(by: { $0.count < $1.count })
    }
}

#Preview {
    ContentView()
}
