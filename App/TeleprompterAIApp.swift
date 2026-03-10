import SwiftUI

@main
struct TeleprompterAIApp: App {
    @StateObject private var teleprompterEngine = TeleprompterEngine()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(teleprompterEngine)
        }
    }
}