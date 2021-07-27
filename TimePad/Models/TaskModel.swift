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
    let date: Date
    let durationSeconds: Int
    var passedSeconds: Int = 0
    let icon: Icon
    let tags: [Tag]?
}
