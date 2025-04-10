//
//  InverseKinematics.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import SwiftUI

struct InverseKinematics: View {
    @State private var angles: [Double] = [90, 90, 90]
    @State private var lengths: [Double] = [200, 100, 200]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let angles = calculateAngles(self.angles)
                let positions = calculatePostions(angles, geometry)
                
                ZStack {
                    ForEach(0..<3) { i in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.accentColor.opacity(1 / (Double(i) / 0.7)))
                            .frame(width: 50, height: lengths[i])
                            .rotationEffect(Angle(degrees: angles[i]), anchor: .bottom)
                            .position(positions[i])
                    }
                }
            }
            
            ForEach(0..<3) { i in
                Text("Angle \(i+1): \(Int(self.angles[i]))°")
                Slider(value: $angles[i], in: 0...180, step: 1)
            }
            .padding()
        }
    }
    
    func calculateAngles(_ angles: [Double]) -> [Double] {
        let angle1 = angles[0] - 90
        let angle2 = angle1 + angles[1] - 90
        let angle3 = angle2 + angles[2] - 90
        return [angle1, angle2, angle3]
    }
    
    func calculatePostions(_ angles: [Double],_ geometry: GeometryProxy) -> [CGPoint] {
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height - 20
        
        let x1 = lengths[0] * sin(Angle(degrees: angles[0]).radians)
        let y1 = -lengths[0] * cos(Angle(degrees: angles[0]).radians)
        
        let x2 = x1 + lengths[1] * sin(Angle(degrees: angles[1]).radians)
        let y2 = y1 + (-lengths[1] * cos(Angle(degrees: angles[1]).radians))
        
        return [CGPoint(x: centerX, y: centerY - lengths[0] / 2), CGPoint(x: centerX + x1, y: centerY + y1 - lengths[1] / 2), CGPoint(x: centerX + x2, y: centerY + y2 - lengths[2] / 2)]
    }
}

#Preview {
    InverseKinematics()
}
