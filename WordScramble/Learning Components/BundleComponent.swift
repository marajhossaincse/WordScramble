//
//  BundleComponent.swift
//  WordScramble
//
//  Created by Maraj Hossain on 9/6/23.
//

import SwiftUI

struct BundleComponent: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                fileContents
            }
        }
    }
}

struct BundleComponent_Previews: PreviewProvider {
    static var previews: some View {
        BundleComponent()
    }
}
