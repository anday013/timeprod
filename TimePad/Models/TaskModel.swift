//
//  TaskModel.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation

struct Task: Codable, Identifiable {
    var id = UUID().uuidString
    let title: String
    let durationHours: Int
    let durationMinutes: Int
    let durationSeconds: Int
    let icon: String
    let backgroundColor: String
    let tags: [Tag]?
}
