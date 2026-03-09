import SwiftUI

struct CameraPromptView: View {
    @State private var isRecording = false

    var body: some View {
        VStack {
            Text("Camera Preview")
                .font(.headline)
                .padding()

            Rectangle() // Placeholder for camera preview
                .frame(height: 300)
                .foregroundColor(.black)

            Text("Script Display")
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
        }
    }

    private func startRecording() {
        isRecording = true
        // Add functionality to start recording
    }

    private func stopRecording() {
        isRecording = false
        // Add functionality to stop recording
    }
}

struct CameraPromptView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPromptView()
    }
}