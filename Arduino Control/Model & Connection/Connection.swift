//
//  Connection.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import Foundation
import SwiftUI

class ConnectionService {
    static func sendRequest(command: ControlCommand, completion: @escaping (Result<Void, Error>) -> Void) {
        @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
        
        guard let url = URL(string: "http://\(arduinoIP)/control") else {
            completion(.failure(NSError(domain: "ConnectionService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(command)
            request.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
}
