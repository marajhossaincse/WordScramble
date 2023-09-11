//
//  ContentView.swift
//  WordScramble
//
//  Created by Maraj Hossain on 9/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word:", text: $newWord)
                        .autocapitalization(.none)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in

                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                    Text("Current score: \(score)")
                        .font(.headline)
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart", action: startGame)
            }
        }
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
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

        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        return misspelledRange.location == NSNotFound
    }

    func isShort(word: String) -> Bool {
        if word.count < 4 {
            return false
        }
        return true
    }

    func isStartWord(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        return true
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }

    func countScore(word: String) {
        score = score + word.count
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(
                title: "Word used already",
                message: "Be more original!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up!")
            return
        }

        guard isShort(word: answer) else {
            wordError(
                title: "Word too short",
                message: "You neeed to write words at least 4 characters long.")
            return
        }

        guard isStartWord(word: answer) else {
            wordError(
                title: "Word is the same",
                message: "You cannot repeat the word!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
            countScore(word: answer)
        }
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
