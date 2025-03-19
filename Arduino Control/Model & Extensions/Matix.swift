//
//  Matix.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct Matrix: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var index: Int?
    var values: [[Bool]]
}
