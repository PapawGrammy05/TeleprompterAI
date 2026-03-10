import SwiftUI

struct CameraPromptView: View {
    @StateObject private var speechManager = SpeechManager()
    @StateObject private var teleprompter = TeleprompterEngine()
    @State private var isRecording = false

    var body: some View {
        VStack {
            Text("Camera Preview")
                .font(.headline)
                .padding()

            Rectangle() // Placeholder for camera preview
                .frame(height: 300)
                .foregroundColor(.black)

            Text(teleprompter.script)
                .padding()

            HStack {
                Button(action: {
                    startRecording()
                }) {
                    Text("Start Recording")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }

                Button(action: {
                    stopRecording()
                }) {
                    Text("Stop Recording")
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
        }.onReceive(speechManager.$transcript) { text in
         teleprompter.updateProgress(using: text)
}
    }

private func startRecording() {
    isRecording = true
    speechManager.requestPermissions()
    try? speechManager.startListening()
}

private func stopRecording() {
    isRecording = false
    speechManager.stopListening()
}
}

struct CameraPromptView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPromptView()
    }
}