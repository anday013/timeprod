//
//  AddTaskViewModel.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    @Published var title: String = "test"
    @Published var date: Date = Date()
    @Published var durationHours: Int = 0
    @Published var durationMinutes: Int = 0
    @Published var durationSeconds: Int = 0
    @Published var selectedTags: [Tag] = []
    @Published var selectedIcon: Icon = Icon(imageName: "monitor", backgroundColor: "9B51E0")
    @Published var showIconPicker: Bool = false
    
    init() {
        self.validator()
    }
    
    func validator() {
        
    }
    
    func generateTaks() -> Task {
       return Task(title: title, date: date, durationSeconds: durationHours * Constants.secondsInHour + durationMinutes * Constants.secondsInMinutes, icon: selectedIcon, tags: selectedTags)
    }

}
