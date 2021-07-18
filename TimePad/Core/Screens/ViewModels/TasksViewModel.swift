//
//  TasksViewModel.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation

class TasksViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task? = nil
    
    init() {
        let tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71"),
            Tag(name: "Workout", fontColor: "FFA656"),
            Tag(name: "Reading", fontColor: "07E092"),
        ]
        
        
        tasks = [
            Task(title: "Learn IOS", durationHours: 2, durationMinutes: 0, durationSeconds: 0, icon: "monitor", backgroundColor: "9B51E0", tags: [tags[0], tags[1]]),
            Task(title: "Read 10 pages of book", durationHours: 1, durationMinutes: 0, durationSeconds: 0, icon: "book", backgroundColor: "07E092", tags: [tags[3]]),
            Task(title: "Learn HTML & CSS", durationHours: 0, durationMinutes: 45, durationSeconds: 0, icon: "code", backgroundColor: "FD5B71", tags: [tags[2]])
        ]
    }
}
