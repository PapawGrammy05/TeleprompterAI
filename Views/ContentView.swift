import SwiftUI

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var speechManager = SpeechManager()

    var body: some View {
        TabView {
            CameraPromptView()
                .tabItem {
                    Label("Camera", systemImage: "camera")
                }

            ScriptEditorView()
                .tabItem {
                    Label("Script Editor", systemImage: "doc.text")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}