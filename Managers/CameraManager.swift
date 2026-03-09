import AVFoundation
import SwiftUI

final class CameraManager: NSObject, ObservableObject {
    @Published var permissionGranted = false
    let session = AVCaptureSession()

    func requestPermissions() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async { 
                self.permissionGranted = granted
                if granted { self.configureSession() }
            }
        }
    }

    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .high

        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera),
              session.canAddInput(input) else {
            session.commitConfiguration()
            return
        }

        session.addInput(input)
        session.commitConfiguration()

        DispatchQueue.global(qos: .userInitiated).async { self.session.startRunning() }
    }
}