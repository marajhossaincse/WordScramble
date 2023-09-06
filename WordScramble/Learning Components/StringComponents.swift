//
//  StringComponents.swift
//  WordScramble
//
//  Created by Maraj Hossain on 9/6/23.
//

import SwiftUI

struct StringComponents: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    func test() {
        let word = "swift"
        let checker = UITextChecker()

        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        let allGood = misspelledRange.location == NSNotFound
    }
}

struct StringComponents_Previews: PreviewProvider {
    static var previews: some View {
        StringComponents()
    }
}
