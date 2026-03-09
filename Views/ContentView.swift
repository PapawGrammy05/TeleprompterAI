import SwiftUI

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var speechManager = SpeechManager()
    @StateObject private var teleprompterEngine = TeleprompterEngine()

    var body: some View {
        TabView {
            CameraPromptView(cameraManager: cameraManager)
                .tabItem {
                    Label("Camera", systemImage: "camera")
                }

            ScriptEditorView(speechManager: speechManager)
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