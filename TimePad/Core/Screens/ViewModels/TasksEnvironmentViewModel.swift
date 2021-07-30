//
//  TasksViewModel.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation
import Combine

class TasksEnvironmentViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task? = nil
    @Published var activeTask: Task? = nil
    @Published var tags: [Tag] = []
    @Published var icons: [Icon] = []
    var timer: AnyCancellable?
    var activeTaskListener: AnyCancellable?
    
    init() {
        tags = [
            Tag(name: "Work", fontColor: "FD5B71"),
            Tag(name: "Coding", fontColor: "FD5B71"),
            Tag(name: "Workout", fontColor: "FFA656"),
            Tag(name: "Reading", fontColor: "07E092"),
        ]
        
        icons = [
            Icon(imageName: "monitor", backgroundColor: "9B51E0"),
            Icon(imageName: "book", backgroundColor: "07E092"),
            Icon(imageName: "code", backgroundColor: "FD5B71")
            
        ]
        
        
        tasks = [
            Task(title: "Learn IOS", date: Date(), durationSeconds: 7200, icon: icons[0], tags: [tags[0], tags[1]]),
            Task(title: "Read 10 pages of book", date: Date() + 5, durationSeconds: 3600, icon: icons[1], tags: [tags[3]]),
            Task(title: "Learn HTML & CSS", date: Date(), durationSeconds: 10, icon: icons[2], tags: [tags[2]])
        ]
        
        setupTimer()
        addTaskSubscriber(taskListener: $activeTask)
    }
    
    private func setupTimer() {
        timer = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _tasks in
                guard let self = self else {return}
                self.updateActiveTaskTime(seconds: 1)
            })
    }
    
    // Update tasks array each time when activeTask get updated
    private func addTaskSubscriber(taskListener: Published<Task?>.Publisher) {
        activeTaskListener = taskListener.map { (task) -> Task? in
            return task
        }
        .sink(receiveValue: { task in
            guard let task = task else {return}
            if let activeTaskIndex = self.tasks.firstIndex(where: { $0.id == task.id}) {
                self.tasks[activeTaskIndex] = task
            }
        })
    }
    
    private func updateActiveTaskTime(seconds: Int) {
        guard let activeTask = self.activeTask,
            activeTask.passedSeconds < activeTask.durationSeconds else {return}
        self.activeTask?.passedSeconds += seconds
        guard let selectedTask = self.selectedTask,
              selectedTask.id == self.activeTask?.id else {return}
        self.selectedTask?.passedSeconds += seconds
        
    }
    
    
    // PUBLIC FUNCTIONS
    func addTask(_ task: Task) {
        tasks.append(task)
    }
}
