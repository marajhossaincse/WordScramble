//
//  ListComponent.swift
//  WordScramble
//
//  Created by Maraj Hossain on 9/5/23.
//

import SwiftUI

struct ListComponent: View {
    var people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List(people, id: \.self) {
            Text("\($0)")
//            Section("Section 1") {
//                Text("Static row 1")
//                Text("Static row 2")
//            }
//
//            Section("Section 2") {
//                ForEach(0 ..< 5) {
//                    Text("Dynamic row \($0)")
//                }
//            }
//
//            Section("Section 3") {
//                Text("Static row 3")
//                Text("Static row 4")
//            }

//            Text("Hello World!")
//            Text("Hello World!")
//            Text("Hello World!")
//            Text("Hello World!")
        }
        .listStyle(.grouped)
    }
}

struct ListComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListComponent()
    }
}
