import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var engine: TeleprompterEngine
    @State private var matchingThreshold: Double = 0.65
    @State private var textSize: Double = 30
    @State private var isMirroredMode: Bool = false
    @State private var selectedLanguage: String = "en-US"
    @State private var videoQuality: String = "1080p"
    @State private var backgroundOpacity: Double = 0.35

    let languages = ["English (US)", "Spanish", "French", "German", "Chinese"]
    let videoQualities = ["480p", "720p", "1080p"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Speech Recognition")) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Matching Threshold")
                            Spacer()
                            Text(String(format: "%.0f%%", matchingThreshold * 100)).font(.headline)
                        }
                        Slider(value: $matchingThreshold, in: 0.5...0.95, step: 0.05)
                    }
                }
                Section(header: Text("Display")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Text Size")
                            Spacer()
                            Text("\(Int(textSize))pt").font(.headline)
                        }
                        Slider(value: $textSize, in: 16...50, step: 2)
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Background Opacity")
                            Spacer()
                            Text(String(format: "%.0f%%", backgroundOpacity * 100)).font(.headline)
                        }
                        Slider(value: $backgroundOpacity, in: 0...1, step: 0.05)
                    }
                    Toggle("Mirrored Mode", isOn: $isMirroredMode)
                }
                Section(header: Text("Video")) {
                    Picker("Quality", selection: $videoQuality) {
                        ForEach(videoQualities, id: \.self) { quality in
                            Text(quality).tag(quality)
                        }
                    }
                }
                Section {
                    Button(action: resetSettings) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset to Defaults")
                        }
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func resetSettings() {
        matchingThreshold = 0.65
        textSize = 30
        isMirroredMode = false
        selectedLanguage = "en-US"
        videoQuality = "1080p"
        backgroundOpacity = 0.35
    }
}

#Preview {
    SettingsView()
        .environmentObject(TeleprompterEngine())
}