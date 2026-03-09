import SwiftUI

struct ScriptEditorView: View {
    @State private var scriptText: String = ""

    var body: some View {
        TextEditor(text: $scriptText)
            .padding()
            .navigationTitle("Script Editor")
    }
}