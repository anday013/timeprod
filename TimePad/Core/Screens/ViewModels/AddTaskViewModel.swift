//
//  AddTaskViewModel.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var durationHours: Int = 0
    @Published var durationMinutes: Int = 0
    @Published var durationSeconds: Int = 0

}
