//
//  Connection.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import Foundation
import SwiftUI

class ConnectionService {
    static func sendRequest(command: ControlCommand) {
        @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
        guard let url = URL(string: "http://\(arduinoIP)/control") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(command)
        
        if let httpBody = request.httpBody, let jsonString = String(data: httpBody, encoding: .utf8) {
            print("Request JSON: \(jsonString)")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response Data: \(responseString)")
            }
        }.resume()
    }
}
