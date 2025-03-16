//
//  Connection.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import Foundation
import SwiftUI

class ConnectionService {
    static func sendRequest(command: ControlCommand, arduinoIP: String) {
        
        guard let url = URL(string: "http://\(arduinoIP)/control") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(command)
        
        URLSession.shared.dataTask(with: request).resume()
    }
}
