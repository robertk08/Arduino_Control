import SwiftUI
import CoreMotion

struct TiltRectangleView: View {
    @StateObject private var motionManager = MotionManager()
    @Binding var roll: Double
    
    var body: some View {
        GeometryReader { geometry in
            let diagonale = sqrt(pow(geometry.size.width, 2) + pow(geometry.size.height, 2))
            let height: CGFloat = geometry.size.height * 2

            let cx = geometry.size.width / 2 - height / 2 * sin(motionManager.roll)
            let cy = geometry.size.height / 2 + height / 2 * cos(motionManager.roll)
            
            Rectangle()
                .opacity(0.6)
                .frame(width: diagonale, height: height)
                .rotationEffect(.radians(motionManager.roll))
                .position(x: cx, y: cy)
        }
        .onReceive(motionManager.$roll) { newValue in
            if newValue < 0 {
                roll = abs(newValue) - 0.5
            }
            if abs(newValue) > 0.5 {
                roll = newValue * 1.8
            }
        }
    }
}

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var roll: Double = 0.0
    
    init() {
        startMotionUpdates()
    }
    
    private func startMotionUpdates() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.startDeviceMotionUpdates(to: .main) { data, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.roll = data.attitude.roll * 0.75
                        print(self.roll)
                    }
                }
            }
        }
    }
}

#Preview {
    TiltRectangleView(roll: .constant(0))
}
